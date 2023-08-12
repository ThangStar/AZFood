import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_toolbar.dart';

class CurrentBookingScreen extends StatefulWidget {
  const CurrentBookingScreen({super.key});

  @override
  State<CurrentBookingScreen> createState() => _CurrentBookingScreenState();
}

class _CurrentBookingScreenState extends State<CurrentBookingScreen> {
  List<ProductBooking> productBookings = [
    ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 0,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    ),
     ProductBooking(
      name: "name",
      type: "type",
      money: 2000,
      amount: 20,
      image:
          "https://thumbs.dreamstime.com/b/hamberger-sauce-piece-big-hamburger-close-up-shot-snack-drink-background-144073056.jpg",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomActionBill(),
      body: SingleChildScrollView(
        child: Container(
          color: colorScheme(context).tertiary,
          child: Column(
            children: [
              MyToolbar(
                title: "Hôm nay",
                leading: MyIconButtonBlur(
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).onPrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                trailling: [
                  MyIconButtonBlur(
                    icon: Icon(Icons.more_horiz_sharp,
                        color: colorScheme(context).onPrimary),
                    onTap: () {},
                  )
                ],
                content: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bàn 1",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 20,
                                    color: colorScheme(context).onPrimary),
                          ),
                          Text(
                            "Số lượng: 8",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 12,
                                    color: colorScheme(context)
                                        .onPrimary
                                        .withOpacity(0.6)),
                          ),
                        ],
                      ),
                      MyButtonBlur(
                        text: "Thêm mới",
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: productBookings.length,
                itemBuilder: (context, index) {
                  ProductBooking productBooking = productBookings[index];
                  return ItemProduct(productBooking: productBooking);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomActionBill extends StatelessWidget {
  const BottomActionBill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tạm tính",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "920.000đ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Hủy bàn",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: colorScheme(context).error,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                MyOutlineButton(
                  text: 'Quay lại',
                  onTap: () {},
                ),
                SizedBox(
                  width: 10,
                ),
                MyButtonGradient(
                  text: "Thanh toán",
                  onTap: () {},
                )
              ],
            )
          ],
        ));
  }
}
