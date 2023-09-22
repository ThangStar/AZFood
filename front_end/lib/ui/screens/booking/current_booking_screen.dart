import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/bill/pay_success_screen.dart';
import 'package:restaurant_manager_app/ui/screens/product/add_product_to_current_booking_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_dialog.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_toolbar.dart';

import '../../blocs/order/order_bloc.dart';

class CurrentBookingScreen extends StatefulWidget {
  const CurrentBookingScreen(
      {super.key, required this.tableID, required this.tableName});

  final int tableID;
  final String tableName;

  @override
  State<CurrentBookingScreen> createState() => _CurrentBookingScreenState();
}

class _CurrentBookingScreenState extends State<CurrentBookingScreen> {
  int amount = 0;

  @override
  void initState() {
    print("tableID change: ${widget.tableID} mounted $mounted");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomActionBill(tableId: widget.tableID),
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
                          color: Colors.white.withOpacity(0.8),
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      trailling: [
                        MyIconButtonBlur(
                          icon: Icon(Icons.more_horiz_sharp,
                              color: Colors.white.withOpacity(0.8)),
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
                                  widget.tableName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 20, color: Colors.white),
                                ),
                                BlocBuilder<ProductBloc, ProductState>(
                                  builder: (context, state) {
                                    return Text(
                                      state.currentProducts != null
                                          ? "Số lượng ${state.currentProducts!.length}"
                                          : "đang tải..",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 12,
                                              color: Colors.white
                                                  .withOpacity(0.6)),
                                    );
                                  },
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
                          return Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: const CircularProgressIndicator());
                        }
                        if (state.currentProducts != null &&
                            state.status == ProductStatus.success) {
                          if (state.currentProducts!.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.no_food_outlined,
                                    size: 64,
                                    color: colorScheme(context)
                                        .scrim
                                        .withOpacity(0.3),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Hiện tại chưa có sản phẩm nào",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: colorScheme(context)
                                            .scrim
                                            .withOpacity(0.3)),
                                  )
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.currentProducts!.toSet().length,
                            itemBuilder: (context, index) {
                              Product product = state.currentProducts!
                                  .toSet()
                                  .elementAt(index);
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
                                                "${product.quantity}",
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
  const BottomActionBill({super.key, required this.tableId});

  final int tableId;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colorScheme(context).background,
          boxShadow: [
            BoxShadow(
              color: colorScheme(context).primary.withOpacity(0.6),
              blurRadius: 6.0,
              spreadRadius: 0.0,
              offset: Offset(0, 1.0), // shadow direction: bottom right
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tạm tính",
                      style: TextStyle(fontSize: 14),
                    ),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        int price = 0;
                        for (Product i in state.currentProducts ?? []) {
                          price += i.price * i.amountCart;
                        }
                        return Text(
                          "${NumberFormat.decimalPattern().format(price)} đ",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      },
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
                Expanded(
                  child: MyOutlineButton(
                    text: 'Quay lại',
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyButtonGradient(
                    text: "Thanh toán",
                    onTap: () {
                      context.read<OrderBloc>().add(PayBillEvent(
                          tableId: tableId,
                          pushScreen: (payStatus, billData) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaySuccessScreen(
                                      payStatus: payStatus, billData: billData),
                                ));
                          }));
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }
}
