import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/services/notification_mobile.dart';
import 'package:restaurant_manager_app/services/notification_window.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/table/table_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/booking/current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/screens/chat/chat_view.dart';
import 'package:restaurant_manager_app/ui/screens/notification/notification_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/item_table.dart';
import 'package:restaurant_manager_app/ui/widgets/my_chip_toogle.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/notification_news.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;
import 'package:restaurant_manager_app/utils/io_client.dart';
import 'package:restaurant_manager_app/model/message.dart' as msg;

import '../../../model/message.dart';
import '../../../routers/socket.event.dart';

class FilterItem {
  String status;
  Color? color;

  FilterItem({required this.status, required this.color});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.constraints, required this.openCurrentBooking});

  final Function openCurrentBooking;
  final BoxConstraints constraints;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // List<String> filterStatus = ["Tất cả", "Hoạt động", "Bận", "Chờ"];

  List<FilterItem> filterStatus = [
    FilterItem(status: 'Tất cả', color: null),
    FilterItem(status: 'Hoạt động', color: Colors.green),
    FilterItem(status: 'Bận', color: Colors.redAccent),
    FilterItem(status: 'Chờ', color: Colors.grey),
    // Thêm các mục khác nếu cần
  ];

  int posFilterStatusSelected = 0;
  bool isShowFilter = true;
  bool chatVisible = false;
  bool notificationVisible = false;

  void _fillData() async {
    LoginResponse? profile = await MySharePreferences.loadProfile();
  }

  late TableBloc tbBloc;
  late ProductBloc prdBloc;

  @override
  void initState() {
    tbBloc = BlocProvider.of<TableBloc>(context);
    prdBloc = BlocProvider.of<ProductBloc>(context);
    //init table
    io.emit('table', {"name": "thang"});
    if (!io.hasListeners("response")) {
      io.on('response', (data) {
        final jsonResponse = data as List<dynamic>;
        List<Model.Table> tables =
            jsonResponse.map((e) => Model.Table.fromJson(e)).toList();
        //name is required having value
        tables.sort((a, b) => a.name!.compareTo(b.name!));
        print("mounted $mounted");
        tbBloc.add(OnTableChange(tables: tables));
      });
    }
    super.initState();
    _fillData();
  }

  @override
  Widget build(BuildContext context) {
    if (checkDevice(widget.constraints.maxWidth, false, true, true)) {
      ZoomDrawer.of(context)!.close();
    }
    return GestureDetector(
      onTap: () {
        if (notificationVisible) {
          setState(() {
            notificationVisible = false;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme(context).background,
                ),
                child: ClipRRect(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          Profile profile = state.profile ??
                              Profile(
                                  id: 0,
                                  username: "ABC",
                                  password: "pass",
                                  name: "ABC",
                                  role: "admin",
                                  phoneNumber: "0123",
                                  email: "email");
                          return ToolbarHome(
                            openChat: widget.constraints.maxWidth > mobileWidth
                                ? () {
                                    setState(() {
                                      chatVisible = !chatVisible;
                                    });
                                  }
                                : () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatViewScreen(
                                                  onClose: () {
                                                    setState(() {
                                                      chatVisible =
                                                          !chatVisible;
                                                    });
                                                  },
                                                )));
                                  },
                            profile: profile,
                            showDrawer: checkDevice(widget.constraints.maxWidth,
                                true, false, false),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Danh sách bàn",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                            ).animate().moveY(),
                            const PageIndex(),
                          ],
                        ),
                      ),
                      const Divider(),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Trạng thái: ",
                                    style: TextStyle(
                                        color: colorScheme(context)
                                            .scrim
                                            .withOpacity(0.8)),
                                    children: [
                                      TextSpan(
                                          text: filterStatus[
                                                  posFilterStatusSelected]
                                              .status,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              IconButton(
                                  color: colorScheme(context).primary,
                                  onPressed: () {
                                    setState(() {
                                      isShowFilter = !isShowFilter;
                                    });
                                  },
                                  icon: Icon(isShowFilter
                                      ? Icons.filter_alt_rounded
                                      : Icons.filter_alt_outlined))
                            ],
                          )),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: AnimatedContainer(
                          height: isShowFilter ? 60 : 0,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          duration: 200.ms,
                          child: Row(children: [
                            Wrap(
                              spacing: 8,
                              children: filterStatus
                                  .asMap()
                                  .entries
                                  .map((e) => MyChipToggle(
                                        isSelected:
                                            posFilterStatusSelected == e.key,
                                        label: e.value.status,
                                        color: e.value.color,
                                        onTap: () {
                                          setState(() {
                                            posFilterStatusSelected = e.key;
                                          });
                                          context.read<TableBloc>().add(
                                              OnFilterTable(status: e.key));
                                        },
                                      ))
                                  .toList(),
                            )
                          ]),
                        ),
                      ),
                      BlocBuilder<TableBloc, TableState>(
                        builder: (context, state) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            primary: false,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 6,
                                    mainAxisSpacing: 6,
                                    mainAxisExtent: 160,
                                    crossAxisCount: checkDevice(
                                        widget.constraints.maxWidth, 2, 3, 4)),
                            itemBuilder: (context, index) {
                              Model.Table table = state.tablesFilter[index];
                              return ItemTable(
                                table: table,
                                onTap: () {
                                  if (table.status == 2) {
                                    //
                                    myAlert(
                                            context,
                                            checkDeviceType(
                                                widget.constraints.maxWidth),
                                            AlertType.error,
                                            "Cảnh báo",
                                            "Không thể order bàn đang bận")
                                        .show(context);
                                  } else {
                                    print("GETTTTTTTTT}");
                                    prdBloc.add(const GetListProductStatusEvent(
                                        status: ProductStatus.loading));
                                    io.emit('listProductByIdTable',
                                        {"id": table.id});
                                    if (!io.hasListeners("responseOrder")) {
                                      io.on('responseOrder', (data) {
                                        print("data order ${data}");
                                        prdBloc.add(OnChangeTableId(
                                            id: data['tableID'] ?? 0));
                                        final jsonResponse =
                                            data['order'] as List<dynamic>;
                                        List<Product> currentProducts =
                                            jsonResponse
                                                .map((e) => Product.fromJson(e))
                                                .toList();
                                        prdBloc.add(GetListProductByIdTable(
                                            currentProducts: currentProducts));
                                      });
                                    }

                                    widget.constraints.maxWidth > mobileWidth
                                        ? showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return CurrentBookingDrawer(
                                                  tableID: table.id ?? 0,
                                                  tableName:
                                                      table.name ?? "--");
                                            },
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CurrentBookingScreen(
                                                tableID: table.id!,
                                                tableName: table.name ?? "đ",
                                              ),
                                            ));
                                  }
                                },
                              )
                                  .animate()
                                  .moveX(
                                      begin: index % 2 != 0 ? -300 : -100,
                                      duration:
                                          Duration(milliseconds: 500 * index),
                                      curve: Curves.fastEaseInToSlowEaseOut)
                                  .fade(duration: (500 * index).ms);
                            },
                            itemCount: state.tablesFilter.length,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )),
              ),
            ),
            chatVisible
                ? Positioned(
                    bottom: 15,
                    right: 90,
                    child: Row(
                      children: [
                        Container(
                            width: 380,
                            height: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorScheme(context).tertiary)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ChatViewScreen(
                                  onClose: () {
                                    if (chatVisible) {
                                      setState(() {
                                        chatVisible = false;
                                      });
                                    }
                                  },
                                ))),
                      ],
                    ))
                : const SizedBox.shrink(),
            notificationVisible
                ? Positioned(
                    top: 85,
                    right: 10,
                    child: Row(
                      children: [
                        Container(
                            width: 400,
                            height: 700,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorScheme(context)
                                        .tertiary
                                        .withOpacity(0.5))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ],
                    ))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class ToolbarHome extends StatelessWidget {
  const ToolbarHome({
    super.key,
    required this.profile,
    this.showDrawer = true,
    this.openChat,
  });

  final Profile profile;
  final bool showDrawer;
  final VoidCallback? openChat;

  @override
  Widget build(BuildContext context) {
    bool shouldTrimText() {
      // Kiểm tra kích thước màn hình và trả về true nếu nhỏ hơn giới hạn
      double screenWidth = MediaQuery.of(context).size.width;
      return screenWidth < 375;
    }

    String trimText(String text, int maxLength) {
      if (text != null && text.length > maxLength) {
        return text.substring(0, maxLength) + '...';
      }
      return text ?? "";
    }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg_app_bar.jpg')),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0), Colors.black]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showDrawer)
                    MyIconButtonBlur(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onTap: () {
                        ZoomDrawer.of(context)!.open();
                      },
                    ),
                  // Text(
                  //   shouldTrimText()
                  //       ? trimText(widget.profile.name ?? '', 15)
                  //       : widget.profile.name ?? "",
                  //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //       fontWeight: FontWeight.bold, color: Colors.white),
                  // ).animate().shimmer(),
                  SingleChildScrollView(
                    child: Text(
                        "Xin chào, ${shouldTrimText() ? trimText(profile.name ?? "".split(' ').last ?? '', 12) : profile.name ?? "".split(' ').last ?? ""}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white)),
                  ),
                  Row(
                    children: [
                      MyIconButtonBlur(
                        icon: Badge(
                          // label: const Text("9+",
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //     )),
                          // backgroundColor: Colors.redAccent,
                          child: const Icon(Icons.chat, color: Colors.white)
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shake(delay: 1.seconds),
                        ),
                        onTap: openChat ?? () {},
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ToolbarProfile(profile: profile),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}

class ToolbarProfile extends StatefulWidget {
  const ToolbarProfile({super.key, required this.profile});

  final Profile profile;

  @override
  State<ToolbarProfile> createState() => _ToolbarProfileState();
}

class _ToolbarProfileState extends State<ToolbarProfile> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(
                        Icons.person_4,
                        color: Colors.white.withOpacity(0.8),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shouldTrimText()
                            ? trimText(widget.profile.name ?? '', 15)
                            : widget.profile.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ).animate().shimmer(),
                      Text(
                        shouldTrimText()
                            ? trimText(widget.profile.email ?? '', 15)
                            : widget.profile.email ?? "",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              FittedBox(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 19),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color:
                                  const Color(0xFFD4D4D8).withOpacity(0.3)))),
                  child: Text(
                    "NV00${widget.profile.id}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().slideX();
  }

  bool shouldTrimText() {
    // Kiểm tra kích thước màn hình và trả về true nếu nhỏ hơn giới hạn
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 375;
  }

  String trimText(String text, int maxLength) {
    if (text != null && text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text ?? "";
  }
}

class CurrentBookingDrawer extends StatefulWidget {
  const CurrentBookingDrawer(
      {super.key, required this.tableID, required this.tableName});

  final int tableID;
  final String tableName;

  @override
  State<CurrentBookingDrawer> createState() => _CurrentBookingDrawerState();
}

class _CurrentBookingDrawerState extends State<CurrentBookingDrawer>
    with TickerProviderStateMixin {
  late AnimationController controllerDialog;
  late Animation<double> transitionDialog;
  double opacity = 0.3;

  void setUpAnimDialog(BuildContext context) {
    Tween<double> tween = Tween(begin: 600, end: 0);
    controllerDialog = AnimationController(vsync: this, duration: 300.ms);
    transitionDialog = tween.animate(
        CurvedAnimation(parent: controllerDialog, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void initState() {
    setUpAnimDialog(context);
    controllerDialog.forward();
    print("init");
    setState(() {
      opacity = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            controllerDialog.reverse();
            setState(() {
              opacity = 0.3;
            });
            transitionDialog.addStatusListener((status) {
              if (status == AnimationStatus.dismissed) {
                Navigator.pop(context);
              }
            });
          },
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: 300.ms,
          child: Transform.translate(
            offset: Offset(transitionDialog.value, 0),
            child: Dialog(
              insetPadding: EdgeInsets.zero,
              alignment: Alignment.topRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CurrentBookingScreen(
                    tableID: widget.tableID, tableName: widget.tableName),
              ),
            ).animate().fadeIn(begin: 0.3, duration: 300.ms),
          ),
        ),
      ],
    );
  }
}
