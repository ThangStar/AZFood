import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/booking/current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_table.dart';
import 'package:restaurant_manager_app/ui/widgets/my_chip_toogle.dart';
import 'package:restaurant_manager_app/ui/widgets/my_drawer.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/notification_news.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Model.Table> tables = [
    Model.Table(
        status: 1, sumPrice: 324234, tableName: "Bàn số 1", time: "2h30p"),
    Model.Table(
        status: 2, sumPrice: 3234, tableName: "Bàn số 2", time: "8h30p"),
    Model.Table(
        status: 2, sumPrice: 3234, tableName: "Bàn số 3", time: "20h30p"),
    Model.Table(status: 0, sumPrice: 0, tableName: "Bàn số 4", time: "0h00p"),
    Model.Table(
        status: 1, sumPrice: 32434, tableName: "Bàn số 5", time: "12h30p"),
    Model.Table(
        status: 0, sumPrice: 32234, tableName: "Bàn số 6", time: "2h32p")
  ];

  List<String> filterStatus = ["Tất cả", "Chờ", "Hoạt động", "bận"];

  int posFilterStatusSelected = 0;
  bool isShowFilter = false;

  void _fillData() async {
    LoginResponse? profile = await MySharePreferences.loadProfile();
    // usernameController.text = ;
  }

  @override
  void initState() {
    super.initState();
    _fillData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: colorScheme(context).primary,
          onPressed: () {},
          child: const Icon(
            Icons.arrow_forward_sharp,
            color: Colors.white,
          )),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: colorScheme(context).onPrimary,
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      image: AssetImage('assets/images/bg_main.png'))),
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
                                        text:
                                            filterStatus[posFilterStatusSelected],
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
                    GridView.builder(
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
                        Model.Table table = tables[index];
                        return ItemTable(
                          table: table,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CurrentBookingScreen(),
                                ));
                          },
                        )
                            .animate()
                            .moveX(
                                begin: index % 2 != 0 ? -300 : -100,
                                duration: Duration(milliseconds: 500 * index),
                                curve: Curves.fastEaseInToSlowEaseOut)
                            .fade(duration: (500 * index).ms);
                      },
                      itemCount: tables.length,
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
                    icon: Icon(
                      Icons.menu,
                      color: colorScheme(context).onPrimary,
                    ),
                    onTap: () {
                      Scaffold.of(context).openDrawer();
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
                      child: Icon(Icons.notifications,
                              color: colorScheme(context).onPrimary)
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shake(delay: 1.seconds),
                    ),
                    onTap: () {
                      Navigator.pop(context);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                          color:
                              colorScheme(context).onPrimary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 19),
                decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            color: const Color(0xFFD4D4D8).withOpacity(0.3)))),
                child: Text(
                  "NV00${profile.id}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().slideX();
  }
}
