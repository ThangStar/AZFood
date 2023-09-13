import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/current_product.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/table/table_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/booking/current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/screens/notification/notification_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_table.dart';
import 'package:restaurant_manager_app/ui/widgets/my_chip_toogle.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/notification_news.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;
import 'package:restaurant_manager_app/utils/io_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> filterStatus = ["Tất cả", "Chờ", "Hoạt động", "bận"];

  int posFilterStatusSelected = 0;
  bool isShowFilter = false;

  void _fillData() async {
    LoginResponse? profile = await MySharePreferences.loadProfile();
    // usernameController.text = ;
  }

  @override
  void initState() {
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
        context.read<TableBloc>().add(OnTableChange(tables: tables));
      });
    }
    super.initState();
    _fillData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorScheme(context).primary,
          onPressed: () {},
          child: Icon(
            Icons.arrow_forward_sharp,
            color: colorScheme(context).onPrimary,
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
                          profile: profile,
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
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
                    AnimatedContainer(
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
                                    },
                                  ))
                              .toList(),
                        )
                      ]),
                    ),
                    BlocBuilder<TableBloc, TableState>(
                      builder: (context, state) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          primary: false,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  mainAxisExtent: 160,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            Model.Table table = state.tables[index];
                            return ItemTable(
                              table: table,
                              onTap: () {
                                context.read<ProductBloc>().add(
                                    const GetListProductStatusEvent(
                                        status: ProductStatus.loading));
                                io.emit(
                                    'listProductByIdTable', {"id": table.id});
                                if (!io.hasListeners("responseOrder")) {
                                  io.on('responseOrder', (data) {
                                    print("products change: $data");

                                    final jsonResponse = data as List<dynamic>;
                                    List<Product> currentProducts = jsonResponse
                                        .map((e) => Product.fromJson(e))
                                        .toList();

                                    // print(
                                    //     'test length a: ${currentProducts.length}');
                                    //     List<Product> productFinal = [];
                                    //     List<Product> new1 = List.from(currentProducts);
                                    // for (var x = 0 ; x <= new1.length+1;x++){
                                    //     for (var y = 0 ; y <= new1.length;y++) {
                                    //       if(new1[x].name != new1[y].name){
                                    //         productFinal.add(new1[x]);
                                    //       }
                                    //     }
                                    // }
                                    // currentProducts.forEach((element) {
                                    //   bool a = currentProducts.indexOf(element);
                                    //   // if(element.id == )
                                    // });

                                    context.read<ProductBloc>().add(
                                        GetListProductByIdTable(
                                            currentProducts: currentProducts));
                                    print("current: ${currentProducts.length}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CurrentBookingScreen(
                                            tableID: table.id!,
                                            tableName: table.name ?? "",
                                            amount: currentProducts.length,
                                          ),
                                        ));
                                  });
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
                          itemCount: state.tables.length,
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
        ],
      ),
    );
  }
}

List splice(List list, int index, [num howMany = 0, dynamic elements]) {
  var endIndex = index + howMany.truncate();
  list.removeRange(index, endIndex >= list.length ? list.length : endIndex);
  if (elements != null) {
    list.insertAll(index, elements is List ? elements : <String>[elements]);
  }
  return list;
}

class ToolbarHome extends StatelessWidget {
  const ToolbarHome({
    super.key,
    required this.profile,
  });
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background.jpg')),
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
                  MyIconButtonBlur(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onTap: () {
                      ZoomDrawer.of(context)!.open();
                    },
                  ),
                  Text("Xin chào, ${profile.name.split(' ').last}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                  MyIconButtonBlur(
                    icon: Badge(
                      backgroundColor: Colors.redAccent,
                      child:
                          const Icon(Icons.notifications, color: Colors.white)
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .shake(delay: 1.seconds),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ));
                    },
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
                        profile.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ).animate().shimmer(),
                      Text(
                        profile.email,
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
