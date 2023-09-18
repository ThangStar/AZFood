import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/my_drawer.dart';

//global variable
final ZoomDrawerController z = ZoomDrawerController();

//main
class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<HomeMenuScreen> {
  int selectedNavRail = 0;
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ZoomDrawer(
            controller: z,
            style: DrawerStyle.style3,
            menuScreenWidth: checkDevice(constraints.maxWidth, sizeScreen.width * 0.8, 0.0, 0.0) ,
            showShadow: true,
            menuBackgroundColor:
                colorScheme(context).onPrimary.withOpacity(0.95),
            mainScreen: Row(
              children: [
                if (constraints.maxWidth > mobileWidth)
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: NavigationRail(
                          trailing: const Text("AZFood.vn"),
                          backgroundColor:
                              colorScheme(context).tertiary.withOpacity(0.8),
                          indicatorColor:
                              colorScheme(context).scrim.withOpacity(0.6),
                          selectedIconTheme: IconThemeData(color: colorScheme(context).onPrimary),
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
                                SizedBox(
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
                          destinations: itemsDrawer.map((e) {
                            return NavigationRailDestination(
                                icon: Icon(e.icon), label: Text(e.label));
                          }).toList(),
                          onDestinationSelected: (value) {
                            setState(() {
                              selectedNavRail = value;
                            });
                          },
                          selectedIndex: selectedNavRail),
                    ),
                  ),
                SizedBox(
                    width: constraints.maxWidth > mobileWidth
                        ? constraints.maxWidth - 120
                        : constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: HomeScreen(constraints: constraints)),
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
