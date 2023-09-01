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
    ItemDrawer(label: "Menu", icon: Icons.menu,),
    ItemDrawer(label: "Bàn", icon: Icons.table_restaurant),
    ItemDrawer(label: "Khách hàng", icon: Icons.person),
    ItemDrawer(label: "Hóa đơn", icon: Icons.book),
    ItemDrawer(label: "Điểm danh", icon: Icons.free_cancellation_sharp),
    ItemDrawer(label: "Lịch đi làm", icon: Icons.calendar_month),
    ItemDrawer(label: "Thống kê", icon: Icons.analytics)
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.8,
      height: double.infinity,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 3, // Chiếm 0.3 chiều cao
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/background.jpg"),
                  ),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg"),
                ),
                otherAccountsPictures: [
                  IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    icon: const Icon(Icons.cancel),
                  )
                ],
                accountName: Text(widget.profile.name),
                accountEmail: Text(
                  widget.profile.email,
                  style: TextStyle(
                    color: colorScheme(context).onPrimary.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8, // Chiếm 0.8 chiều cao
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Quản lí",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: colorScheme(context).scrim,
                          ),
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
                          height: 55,
                          width: posSelected == e.key ? width * 0.8 : 0,
                          child: Container(
                            margin: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              color:
                                  colorScheme(context).primary.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50)),
                            ),
                          ),
                        ),
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.only(
                              left: posSelected == e.key ? 15.0 : 0.0),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                posSelected = e.key;
                              });
                            },
                            leading: Icon(e.value.icon,
                              color: posSelected == e.key ? colorScheme(context).surfaceTint : null,),
                            title: Text(
                              e.value.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                color: posSelected == e.key ? colorScheme(context).surfaceTint : null,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
