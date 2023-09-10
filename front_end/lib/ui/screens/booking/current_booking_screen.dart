import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/product/add_product_to_current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_dialog.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_toolbar.dart';
import 'package:restaurant_manager_app/utils/io_client.dart';

class CurrentBookingScreen extends StatefulWidget {
  const CurrentBookingScreen({super.key, required this.tableID});
  final int tableID;

  @override
  State<CurrentBookingScreen> createState() => _CurrentBookingScreenState();
}

class _CurrentBookingScreenState extends State<CurrentBookingScreen> {
  @override
  void initState() {
    print("tableID change: ${widget.tableID} mounted $mounted");

    super.initState();
  }

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
                          Navigator.of(context, rootNavigator: true).pop();
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
                                            AddProductToCurrentBookingScreen(
                                                tableID: widget.tableID)));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state.status == ProductStatus.loading) {
                          return CircularProgressIndicator();
                        }
                        if (state.currentProducts != null &&
                            state.status == ProductStatus.success) {
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.currentProducts!.length,
                            itemBuilder: (context, index) {
                              Product product = state.currentProducts![index];
                              return ItemProduct(
                                product: product,
                                subTitle:
                                    SubTitleItemCurrentBill(product: product),
                                trailling: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: colorScheme(context)
                                                    .primary
                                                    .withOpacity(0.3)),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Material(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: Icon(Icons.remove,
                                                        color:
                                                            colorScheme(context)
                                                                .primary),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                " 10 ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: colorScheme(context)
                                                        .scrim
                                                        .withOpacity(0.8)),
                                              ),
                                              Material(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: Icon(Icons.add,
                                                        color:
                                                            colorScheme(context)
                                                                .primary),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    )
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
                        color: const Color(0xFFE4295D),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
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
