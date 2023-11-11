import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import 'package:restaurant_manager_app/ui/screens/bill/bill_screen.dart';
import 'package:restaurant_manager_app/ui/screens/booking/current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/screens/calendar/calendar_screen.dart';
import 'package:restaurant_manager_app/ui/screens/calendar/verify_screen.dart';
import 'package:restaurant_manager_app/ui/screens/chart/chart_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/screens/info/info_screen.dart';
import 'package:restaurant_manager_app/ui/screens/info/profile_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/flower_painter.dart';
import 'package:restaurant_manager_app/ui/widgets/my_dialog.dart';
import 'package:restaurant_manager_app/ui/widgets/my_drawer.dart';

import '../../../main.dart';
import '../../../storage/share_preferences.dart';

//global variable
final ZoomDrawerController z = ZoomDrawerController();

//main
class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

enum PageNavRail { table, bill, check, calendar, chart, profile }

class _ZoomState extends State<HomeMenuScreen> {
  int selectedNavRail = 0;
  List<PageNavRail> pages = [
    PageNavRail.table,
    PageNavRail.bill,
    PageNavRail.check,
    PageNavRail.calendar,
    PageNavRail.chart,
    PageNavRail.profile,
  ];
  bool isDarkTheme = false;
  ui.Image? flower;
  final GlobalKey<ScaffoldState> keyCurrentBooking = GlobalKey<ScaffoldState>();

  void loadImage(String imageName) async {
    final data = await rootBundle.load('assets/images/$imageName');
    ui.Image flower = await decodeImageFromList(data.buffer.asUint8List());
    setState(() {
      this.flower = flower;
    });
  }

  @override
  void initState() {
    loadImage("3d.jpg");
    MySharePreferences.getIsDarkTheme().then((value) {
      setState(() {
        isDarkTheme = value ?? false ? true : false;
      });
    });
    super.initState();
  }

  void logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => MyDialog(
              title: "Đăng xuất?",
              content: "Bạn có chắc chắn muốn đăng xuất",
              onTapLeading: () {
                MySharePreferences.setRememberMe(false);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false);
              },
              onTapTrailling: () {
                Navigator.pop(context);
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return Stack(
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return ZoomDrawer(
                controller: z,
                style: DrawerStyle.style3,
                menuScreenWidth: checkDevice(
                    constraints.maxWidth, sizeScreen.width * 0.8, 0.0, 0.0),
                showShadow: true,
                menuBackgroundColor:
                    colorScheme(context).onPrimary.withOpacity(0.95),
                mainScreen: Row(
                  children: [
                    if (constraints.maxWidth > mobileWidth)
                      Row(
                        children: [
                          SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height),
                              child: IntrinsicHeight(
                                child: NavigationRail(
                                    trailing: const Text("AZFood.vn"),
                                    backgroundColor: colorScheme(context)
                                        .tertiary
                                        .withOpacity(0.8),
                                    indicatorColor: colorScheme(context)
                                        .scrim
                                        .withOpacity(0.6),
                                    selectedIconTheme: IconThemeData(
                                        color: colorScheme(context).onPrimary),
                                    elevation: 5,
                                    leading: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          ClipOval(
                                            child: SizedBox(
                                                width: 60,
                                                height: 60,
                                                child: Image.asset(
                                                  "assets/images/chicken.png",
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Text(
                                            'AZFood',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    labelType: NavigationRailLabelType.all,
                                    destinations: [
                                      ...itemsDrawer.map((e) {
                                        return NavigationRailDestination(
                                            icon: Icon(e.icon),
                                            label: Text(e.label));
                                      }).toList(),
                                      NavigationRailDestination(
                                          icon: Icon(Icons.logout),
                                          label: GestureDetector(
                                              onTap: () {
                                                logout(context);
                                              },
                                              child: Text("Đăng xuất"))),
                                      NavigationRailDestination(
                                          icon: Switch(
                                            value: isDarkTheme,
                                            activeColor: const Color.fromRGBO(43, 43, 53, 1),
                                            activeTrackColor: const Color.fromRGBO(62, 62, 77, 1),
                                            onChanged: (value) async {
                                              await MySharePreferences
                                                  .setIsDarkTheme(value);
                                              if (value) {
                                                MyApp.themeNotifier.value =
                                                    ThemeMode.dark;
                                              } else {
                                                MyApp.themeNotifier.value =
                                                    ThemeMode.light;
                                              }
                                              setState(() {
                                                isDarkTheme = value;
                                              });
                                            },
                                          ),
                                          label: const Text("Chế độ tối"))
                                    ],
                                    onDestinationSelected: (value) {
                                      print(value);
                                      print(itemsDrawer.length);
                                      if (value != itemsDrawer.length + 1) {
                                        if (value == itemsDrawer.length) {
                                          logout(context);
                                          return;
                                        }
                                        setState(() {
                                          selectedNavRail = value;
                                        });
                                      }
                                    },
                                    selectedIndex: selectedNavRail),
                              ),
                            ),
                          ),
                          const VerticalDivider(width: 1),
                        ],
                      ),
                    SizedBox(
                        width: constraints.maxWidth > mobileWidth
                            ? constraints.maxWidth - 110
                            : constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: (() {
                          switch (pages[selectedNavRail]) {
                            case PageNavRail.table:
                              return HomeScreen(
                                constraints: constraints,
                                openCurrentBooking: () => keyCurrentBooking
                                    .currentState!
                                    .openDrawer(),
                              );
                            case PageNavRail.bill:
                              return BillScreen(constraints: constraints);
                            case PageNavRail.chart:
                              return ProfileScreen(constraints: constraints);
                            case PageNavRail.calendar:
                              return ChartScreen(constraints: constraints);
                            case PageNavRail.check:
                              return CalendarScreen(constraints: constraints);
                            default:
                              return HomeScreen(
                                constraints: constraints,
                                openCurrentBooking: () => keyCurrentBooking
                                    .currentState!
                                    .openDrawer(),
                              );
                          }
                        }())),
                  ],
                ),
                angle: 0,
                menuScreen:
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return MyDrawer(
                        profile: state.profile ??
                            Profile(
                                id: 0,
                                username: "username",
                                password: "password",
                                name: "name",
                                role: "role",
                                phoneNumber: "phoneNumber",
                                email: "email"));
                  },
                ));
          },
        ),
        flower == null
            ? const SizedBox.shrink()
            : IgnorePointer(
                child: SizedBox(
                  width: sizeScreen.width,
                  height: sizeScreen.height,
                  child: FittedBox(
                    child: SizedBox(
                      width: 400,
                      height: 400,
                      child: CustomPaint(
                        painter: FlowerPainter(flower: flower!),
                      ),
                    ),
                  ),
                ),
              ),
        // IgnorePointer(
        //   child: Scaffold(
        //     backgroundColor: Colors.transparent,
        //     appBar: AppBar(
        //       // automaticallyImplyLeading: false,
        //       backgroundColor: Colors.transparent,
        //     ),
        //     key: keyCurrentBooking,
        //     endDrawer: SizedBox(
        //         width: sizeScreen.width * 0.5,
        //         child: CurrentBookingScreen(tableID: 1, tableName: "OK")),
        //   ),
        // )
      ],
    );
  }
}
