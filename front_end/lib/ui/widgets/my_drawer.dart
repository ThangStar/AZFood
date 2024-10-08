import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/initial/initial_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import 'package:restaurant_manager_app/ui/screens/bill/bill_screen.dart';
import 'package:restaurant_manager_app/ui/screens/calendar/calendar_screen.dart';
import 'package:restaurant_manager_app/ui/screens/chart/chart_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/screens/info/profile_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_dialog.dart';
import 'package:restaurant_manager_app/ui/widgets/my_tabbar_theme.dart';

import '../../storage/share_preferences.dart';
import '../screens/auth/login_screen.dart';
import 'my_dialog.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.profile});

  final Profile profile;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

enum TypeDrawer { home, order, calendar, analytics, profile, logout }

class ItemDrawer {
  final String label;
  final IconData icon;
  final TypeDrawer typeDrawer;

  ItemDrawer(
      {required this.label, required this.icon, required this.typeDrawer});
}

final List<ItemDrawer> itemsDrawer = [
  ItemDrawer(
      label: "Bàn", 
      icon: Icons.table_restaurant, 
      typeDrawer: TypeDrawer.home),
  ItemDrawer(
    label: "Hóa đơn", 
    icon: Icons.book, 
    typeDrawer: TypeDrawer.order),
  ItemDrawer(
      label: "Điểm danh",
      icon: Icons.free_cancellation_sharp,
      typeDrawer: TypeDrawer.calendar),
  ItemDrawer(
      label: "Thống kê",
      icon: Icons.analytics,
      typeDrawer: TypeDrawer.analytics),
  ItemDrawer(
      label: "Cá nhân", icon: Icons.person, typeDrawer: TypeDrawer.profile),
  // ItemDrawer(
  //     label: "Đăng xuất", icon: Icons.logout, typeDrawer: TypeDrawer.logout),
];

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => MyDialog(
              title: "Đăng xuất?",
              content: "Bạn có chắc chắn muốn đăng xuất",
              onTapLeading: () {
                Navigator.pop(context);
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SizedBox(
                width: width * 0.8,
                height: double.infinity,
                child: Container(
                  color: colorScheme(context).tertiary.withOpacity(0.2),
                  child: Column(
                    children: [
                      UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/bg_app_bar.jpg"),
                          ),
                        ),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: widget.profile.imgUrl != null
                              ? Image.network(
                                  widget.profile.imgUrl ?? "",
                                  width: 23,
                                  height: 23,
                                  fit: BoxFit.cover,
                                ).image
                              : const AssetImage("assets/images/avatar.jpg"),
                        ),
                        otherAccountsPictures: [
                          IconButton(
                            onPressed: () {
                              ZoomDrawer.of(context)!.close();
                            },
                            icon: const Icon(Icons.cancel),
                          )
                        ],
                        accountName: Text(widget.profile.name ?? ""),
                        accountEmail: Text(
                          widget.profile.email ?? "",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Expanded(
                        child: BlocBuilder<InitialBloc, InitialState>(
                          builder: (context, state) {
                            return ListView(
                              padding: const EdgeInsets.all(0),
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text(
                                      "Quản lí",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: colorScheme(context)
                                                .scrim
                                                .withOpacity(0.6),
                                          ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorScheme(context).tertiary),
                                    borderRadius: BorderRadius.circular(8),
                                    color: colorScheme(context).onPrimary,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...itemsDrawer.asMap().entries.map((e) {
                                        return AnimatedContainer(
                                          onEnd: () {},
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: state.posDrawerSelected ==
                                                    e.key
                                                ? colorScheme(context).primary
                                                : null,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          duration: 200.ms,
                                          child: ListTile(
                                            onTap: () async {
                                              setState(() {
                                                context.read<InitialBloc>().add(
                                                    ChangePosSelectedDrawer(
                                                        newPos: e.key));
                                              });
                                              await Future.delayed(300.ms);
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                              final type = e.value.typeDrawer;
                                              switch (type) {
                                                case TypeDrawer.home:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const HomeMenuScreen();
                                                    },
                                                  ));
                                                  break;

                                                case TypeDrawer.order:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const BillScreen();
                                                    },
                                                  ));
                                                  break;

                                                case TypeDrawer.calendar:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const CalendarScreen();
                                                    },
                                                  ));
                                                  break;

                                                case TypeDrawer.analytics:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const ChartScreen();
                                                    },
                                                  ));
                                                  break;

                                                case TypeDrawer.profile:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const ProfileScreen();
                                                    },
                                                  ));
                                                  break;

                                                // case TypeDrawer.logout:
                                                //   // ignore: use_build_context_synchronously
                                                //   showDialog(
                                                //       context: context,
                                                //       builder: (context) => MyDialog(
                                                //         title: "Đăng xuất?",
                                                //         content: "Bạn có chắc chắn muốn đăng xuất",
                                                //         onTapLeading: () {
                                                //           MySharePreferences.setRememberMe(false);
                                                //           Navigator.pushAndRemoveUntil(
                                                //               context,
                                                //               MaterialPageRoute(
                                                //                 builder: (context) => const LoginScreen(),
                                                //               ),
                                                //                   (route) => false);
                                                //         },
                                                //         onTapTrailling: () {
                                                //           Navigator.pop(context);
                                                //         },
                                                //       ));
                                                //   break;
                                                case TypeDrawer.logout:
                                                  // ignore: use_build_context_synchronously
                                                  logout(context);
                                                  break;

                                                default:
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                    builder: (context) {
                                                      return const HomeMenuScreen();
                                                    },
                                                  ));
                                                  break;
                                              }
                                            },
                                            leading: Icon(
                                              e.value.icon,
                                              color: state.posDrawerSelected ==
                                                      e.key
                                                  ? colorScheme(context)
                                                      .onPrimary
                                                  : colorScheme(context)
                                                      .scrim
                                                      .withOpacity(0.6),
                                            ),
                                            title: Text(
                                              e.value.label,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                    color:
                                                        state.posDrawerSelected ==
                                                                e.key
                                                            ? colorScheme(
                                                                    context)
                                                                .onPrimary
                                                            : colorScheme(
                                                                    context)
                                                                .scrim
                                                                .withOpacity(
                                                                    0.8),
                                                    fontSize: 14,
                                                  ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      Container(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: TextButton(
                                        onPressed: () => {
                                          logout(context),
                                        },
                                        style: ButtonStyle(
                                          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
                                          minimumSize: MaterialStateProperty.all<Size>(const Size(500, 55)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 5.0),
                                            Icon(Icons.logout, color: colorScheme(context).scrim.withOpacity(0.6)),
                                            const SizedBox(width: 10.0),
                                            Text("Đăng xuất", textAlign: TextAlign.left, style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(color: colorScheme(context).scrim.withOpacity(0.8)),
                                            ),
                                          ],
                                        )
                                      ),
                                      )
                                      
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: MyTabBarTheme(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
