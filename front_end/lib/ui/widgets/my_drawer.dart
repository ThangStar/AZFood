import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.profile});
  final Profile profile;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class ItemDrawer {
  final String label;
  final IconData icon;

  ItemDrawer({required this.label, required this.icon});
}

class _MyDrawerState extends State<MyDrawer> {
  int posSelected = 0;

  final List<ItemDrawer> items = [
    ItemDrawer(label: "Bàn", icon: Icons.table_bar),
    ItemDrawer(label: "Khách hàng", icon: Icons.person),
    ItemDrawer(label: "Hóa đơn", icon: Icons.book),
    ItemDrawer(label: "Menu", icon: Icons.menu),
    ItemDrawer(label: "Điểm danh", icon: Icons.free_cancellation_sharp),
    ItemDrawer(label: "Lịch đi làm", icon: Icons.calendar_month),
    ItemDrawer(label: "Thống kê", icon: Icons.analytics)
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width * 0.8,
      height: 800,
      child: Expanded(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/background.jpg"))),
                  currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/avatar.jpg")),
                  otherAccountsPictures: [
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                      },
                      icon: const Icon(Icons.cancel),
                    )
                  ],
                  accountName:  Text(widget.profile.name),
                  accountEmail: Text(
                    widget.profile.email,
                    style: TextStyle(
                        color: colorScheme(context).onPrimary.withOpacity(0.6)),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Quản lí",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: colorScheme(context).scrim.withOpacity(0.6)),
                ),
              ),
              ...items.asMap().entries.map((e) {
                return Stack(
                  fit: StackFit.loose,
                  children: [
                    AnimatedPositioned(
                      duration: 200.ms,
                      top: 0,
                      left: 0,
                      width: posSelected == e.key ? width * 0.8 : 0,
                      height: 200,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              color: colorScheme(context)
                                  .primary
                                  .withOpacity(0.6))),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          posSelected = e.key;
                        });
                      },
                      leading: const Icon(Icons.table_bar),
                      title: Text(
                        e.value.label,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: colorScheme(context).scrim.withOpacity(0.6)),
                      ),
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
