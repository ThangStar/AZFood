import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';

class PaySuccessScreen extends StatelessWidget {
  const PaySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).surfaceTint,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                border: Border.all(
                  color: colorScheme(context).onPrimary,
                ),
                borderRadius: BorderRadius.circular(80)),
            child: IconButton(
              padding: const EdgeInsets.all(0),
                onPressed: () {},
                icon: Icon(
                  Icons.question_mark_outlined,
                  color: colorScheme(context).onPrimary,
                )),
          )
        ],
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: colorScheme(context).onPrimary,
        ),
        title: Text(
          "Đã xuất hoá đơn",
          style: TextStyle(fontSize: 22, color: colorScheme(context).onPrimary),
        ),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(200),
            child: SizedBox(
                height: 200,
                child: Center(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: colorScheme(context).onPrimary, width: 6),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(
                      Icons.done,
                      color: colorScheme(context).onPrimary,
                      size: 80,
                    ),
                  ),
                )))),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyButton(
              isOutline: true,
              value: "Quay về",
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyButton(
              value: "Xem hoá đơn",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
