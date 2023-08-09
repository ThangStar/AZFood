import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: ListView(
        children: const [
          UserAccountsDrawerHeader(
              accountName: Text("Nông Văn Thắng"),
              accountEmail: Text("thangpro@gmail.com")),
              ListTile(title: Text("wfdqwfewf"),)
        ],
      ),
    );
  }
}
