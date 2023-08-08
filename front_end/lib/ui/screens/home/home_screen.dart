import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_table.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/notification_news.dart';
import 'package:restaurant_manager_app/ui/widgets/page_index.dart';
import 'package:restaurant_manager_app/model/table.dart' as Model;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Model.Table> tables = [
    Model.Table(
        status: 1, sumPrice: 324234, tableName: "Bàn số 1", time: "2h30p"),
    Model.Table(
        status: 2, sumPrice: 3234, tableName: "Bàn số 2", time: "8h30p"),
    Model.Table(
        status: 2, sumPrice: 3234, tableName: "Bàn số 3", time: "20h30p"),
    Model.Table(
        status: 0, sumPrice: 3234, tableName: "Bàn số 4", time: "18h30p"),
    Model.Table(
        status: 1, sumPrice: 32434, tableName: "Bàn số 5", time: "12h30p"),
    Model.Table(
        status: 0, sumPrice: 32234, tableName: "Bàn số 6", time: "2h32p")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).primary,
        onPressed: () {
        
      },child: Icon(Icons.arrow_forward_sharp, color: Colors.white,)),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                  image: AssetImage('assets/images/bg_main.png'))),
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ToolbarHome(),
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
                            ?.copyWith(fontWeight: FontWeight.bold),
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
                        const Text("Đã áp dụng bộ lọc: "),
                        IconButton(
                            color: colorScheme(context).primary,
                            onPressed: () => null,
                            icon: const Icon(Icons.filter_alt_outlined))
                      ],
                    )),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    Model.Table table = tables[index];
                    return ItemTable(table: table)
                        .animate()
                        .moveX(
                            begin: index % 2 != 0 ? -300 : -100,
                            duration: Duration(milliseconds: 500 * index),
                            curve: Curves.fastEaseInToSlowEaseOut)
                        .fade(duration: (500 * index).ms);
                  },
                  itemCount: tables.length,
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class ToolbarHome extends StatelessWidget {
  const ToolbarHome({
    super.key,
  });

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
                    onTap: () {},
                  ),
                  Text("Xin chào, ABC",
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
                    onTap: () {},
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ToolbarProfile(),
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
  const ToolbarProfile({super.key});

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
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12)),
                      child: IconButton(
                          onPressed: () => null,
                          icon: Icon(
                            Icons.person_4,
                            color: Colors.white.withOpacity(0.8),
                          ))),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nhân viên: ABC",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ).animate(
                        onPlay: (controller) => controller.repeat(),
                      ).tint(color: Color.fromARGB(255, 224, 255, 225), duration: 500.ms, delay: 500.ms).then().tint(color: Colors.white, duration: 500.ms, delay: 500.ms),
                      Text(
                        "25-8-2002",
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
                  "NV0001",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
