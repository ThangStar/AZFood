import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/model/profile.dart';
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> filterStatus = ["Tất cả", "Hoạt động", "bận", "Chờ"];

  int posFilterStatusSelected = 0;
  bool isShowFilter = false;
  bool chatVisible = false;
  bool notificationVisible = false;
  late TableBloc tbBloc;
  late ProductBloc prdBloc;

  void _fillData() async {
    LoginResponse? profile = await MySharePreferences.loadProfile();
    // usernameController.text = ;
  }

  @override
  void initState() {
    tbBloc = BlocProvider.of<TableBloc>(context);
    prdBloc = BlocProvider.of<ProductBloc>(context);
    //init table
    io.emit('table', {"name": "thang"});
    if (!io.hasListeners("response")) {
      io.on('response', (data) {
        print("table change: $data");

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
    return GestureDetector(
      onTap: () {
        if (notificationVisible) {
          setState(() {
            notificationVisible = false;
          });
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: colorScheme(context).primary,
            onPressed: () {},
            child: Icon(
              Icons.arrow_forward_sharp,
              color: Colors.white,
            )),
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
                            openNotification:
                                widget.constraints.maxWidth > mobileWidth
                                    ? () {
                                        setState(() {
                                          notificationVisible =
                                              !notificationVisible;
                                        });
                                      }
                                    : () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotificationScreen(
                                                      onClose: () {
                                                        setState(() {
                                                          notificationVisible =
                                                              !notificationVisible;
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
                      const SizedBox(
                        height: 16,
                      ),
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
                                              posFilterStatusSelected],
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
                                        label: e.value,
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
                                    prdBloc.add(
                                        const GetListProductStatusEvent(
                                            status: ProductStatus.loading));
                                    io.emit('listProductByIdTable',
                                        {"id": table.id});
                                    if (!io.hasListeners("responseOrder")) {
                                      io.on('responseOrder', (data) {
                                        final jsonResponse =
                                            data as List<dynamic>;
                                        List<Product> currentProducts =
                                            jsonResponse
                                                .map((e) => Product.fromJson(e))
                                                .toList();
                                        for (var i in currentProducts) {
                                          int length = currentProducts
                                              .where((j) => j.name == i.name)
                                              .length;
                                          i.quantity = length;
                                        }
                                        prdBloc.add(
                                            GetListProductByIdTable(
                                                currentProducts:
                                                    currentProducts));
                                      });
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CurrentBookingScreen(
                                            tableID: table.id!,
                                            tableName: table.name ?? "dđ",
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
                        height: 24,
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
                                child: NotificationScreen(
                                  onClose: () {
                                    if (notificationVisible) {
                                      setState(() {
                                        notificationVisible = false;
                                      });
                                    }
                                  },
                                ))),
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
    this.openNotification,
  });

  final Profile profile;
  final bool showDrawer;
  final VoidCallback? openChat;
  final VoidCallback? openNotification;

  @override
  Widget build(BuildContext context) {
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
                  Text("Xin chào, ${profile.name ?? "".split(' ').last}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                  Row(
                    children: [
                      MyIconButtonBlur(
                        icon: Badge(
                          label:  Text("9+", style: TextStyle(color: Colors.white,)),
                          backgroundColor: Colors.redAccent,
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
                      MyIconButtonBlur(
                        icon: Badge(
                          backgroundColor: Colors.redAccent,
                          child: const Icon(Icons.notifications,
                                  color: Colors.white)
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shake(delay: 1.seconds),
                        ),
                        onTap: openNotification ?? () {},
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
              height: 30,
            ),
            const NotificationNews(),
          ],
        ),
      ),
    );
  }
}

class ToolbarProfile extends StatelessWidget {
  const ToolbarProfile({super.key, required this.profile});

  final Profile profile;

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
                        profile.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ).animate().shimmer(),
                      Text(
                        profile.email ?? "",
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
                    "NV00${profile.id}",
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
}
