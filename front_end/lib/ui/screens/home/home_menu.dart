import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/bill/bill_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/screens/info/info_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
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

enum PageNavRail { table, bill, check, calendar, rank, profile, logout }

class _ZoomState extends State<HomeMenuScreen> {
  int selectedNavRail = 0;
  List<PageNavRail> pages = [
    PageNavRail.table,
    PageNavRail.bill,
    PageNavRail.check,
    PageNavRail.calendar,
    PageNavRail.rank,
    PageNavRail.profile,
    PageNavRail.logout,
  ];
  bool isDarkTheme = false;

  @override
  void initState() {
    MySharePreferences.getIsDarkTheme().then((value) {
      setState(() {
        isDarkTheme = value ?? false ? true : false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return LayoutBuilder(
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
                              minHeight: MediaQuery.of(context).size.height),
                          child: IntrinsicHeight(
                            child: NavigationRail(
                                trailing: const Text("AZFood.vn"),
                                backgroundColor: colorScheme(context)
                                    .tertiary
                                    .withOpacity(0.8),
                                indicatorColor:
                                    colorScheme(context).scrim.withOpacity(0.6),
                                selectedIconTheme: IconThemeData(
                                    color: colorScheme(context).onPrimary),
                                elevation: 10,
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
                                        icon: Icon(e.icon), label: Text(e.label));
                                  }).toList(),
                                  NavigationRailDestination(
                                      icon: Switch(
                                        value: isDarkTheme,
                                        onChanged: (value) async {
                                          await MySharePreferences.setIsDarkTheme(
                                              value);
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
                                      label: Text("Chế độ tối"))
                                ],
                                onDestinationSelected: (value) {
                                  setState(() {
                                    selectedNavRail = value;
                                  });
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
                          return HomeScreen(constraints: constraints);
                        case PageNavRail.bill:
                          return BillScreen(constraints: constraints);
                        case PageNavRail.profile:
                          return InfoScreen();
                        case PageNavRail.logout:
                          return HomeScreen(constraints: constraints);
                        default:
                          return HomeScreen(constraints: constraints);
                      }
                    }())),
              ],
            ),
            angle: 0,
            menuScreen: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
    );
  }
}
