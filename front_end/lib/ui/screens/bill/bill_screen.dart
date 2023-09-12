import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).background,
      appBar: AppBar(
        title: const Text("Hoá đơn"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SearchBar(
              textStyle: MaterialStatePropertyAll(TextStyle(
                fontSize: 16,
              )),
              padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 10, vertical: 4)),
              hintText: "Tìm theo tên, mã..",
              elevation: const MaterialStatePropertyAll(0),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme(context).tertiary),
                  borderRadius: BorderRadius.circular(6))),
              trailing: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
          TabBar(
              controller:
                  TabController(length: 2, vsync: this, initialIndex: 0),
              tabs: const [
                Tab(
                  child: Text("Gần đây"),
                ),
                Tab(
                  child: Text("Tất cả"),
                )
              ]),
          ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return const ItemBill();
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  color: colorScheme(context).tertiary,
                );
              },
              itemCount: 4)
        ],
      ),
    );
  }
}

class ItemBill extends StatelessWidget {
  const ItemBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "John Doe",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "TB001",
                    style: TextStyle(
                        fontSize: 14,
                        color: colorScheme(context).scrim.withOpacity(0.4)),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    color: Colors.pinkAccent.withOpacity(0.1),
                    child: const Text(
                      "Tiền mặt",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "500.000đ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "20-2-2023",
                    style: TextStyle(
                        color: colorScheme(context).scrim.withOpacity(0.4)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
