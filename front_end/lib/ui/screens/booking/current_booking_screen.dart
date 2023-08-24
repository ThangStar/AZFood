import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
import 'package:restaurant_manager_app/ui/screens/product/add_product_to_current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_dialog.dart';
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
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg_main.png"))),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 18),
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
                                          color:
                                              colorScheme(context).onPrimary),
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddProductToCurrentBookingScreen()));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   primary: false,
                    //   itemCount: productBookings.length,
                    //   itemBuilder: (context, index) {
                    //     ProductBooking productBooking = productBookings[index];
                    //     return ItemProduct(
                    //       productBooking: productBooking,
                    //       subTitle: SubTitleItemCurrentBill(
                    //           productBooking: productBooking),
                    //       trailling: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Center(
                    //             child: Container(
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(6),
                    //                   border: Border.all(
                    //                       color: colorScheme(context).primary),
                    //                   color: colorScheme(context)
                    //                       .primary
                    //                       .withOpacity(0.1),
                    //                 ),
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal: 8, vertical: 2),
                    //                 child: Text(
                    //                   "10",
                    //                   style: TextStyle(
                    //                       fontSize: 14,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: colorScheme(context).primary),
                    //                 )),
                    //           ),
                    //           const SizedBox(
                    //             width: 4,
                    //           ),
                    //           IconButton(
                    //             icon: const Icon(Icons.more_vert),
                    //             onPressed: () {},
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
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
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
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
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return MyDialog(
                          onTapLeading: () {
                            Navigator.pop(context);
                          },
                          onTapTrailling: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                  child: Text(
                    "Hủy bàn",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        color: Color(0xFFE4295D),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                MyOutlineButton(
                  text: 'Quay lại',
                  onTap: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyButtonGradient(
                    text: "Thanh toán",
                    onTap: () {},
                  ),
                )
              ],
            )
          ],
        ));
  }
}
