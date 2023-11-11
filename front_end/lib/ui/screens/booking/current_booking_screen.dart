import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/apis/order/order.api.dart';
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
import '../../utils/size_config.dart';

class CurrentBookingScreen extends StatefulWidget {
  const CurrentBookingScreen(
      {super.key,
      required this.tableID,
      required this.tableName,
      this.constraints});

  final int tableID;
  final String tableName;
  final BoxConstraints? constraints;

  @override
  State<CurrentBookingScreen> createState() => _CurrentBookingScreenState();
}

class _CurrentBookingScreenState extends State<CurrentBookingScreen> {
  int? selectedItem = 2;
  late ProductBloc prdBloc;

  @override
  void initState() {
    prdBloc = BlocProvider.of<ProductBloc>(context);
    print("tableID change: ${widget.tableID} mounted $mounted");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).background,
      bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          int amount = state.status == ProductStatus.success
              ? (state.currentProducts?.length ?? 0)
              : 0;
          return BottomActionBill(
            tableId: widget.tableID,
            selectedItem: selectedItem,
            amount: amount,
          );
        },
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                MyToolbar(
                  title: "Hôm nay",
                  leading: MyIconButtonBlur(
                    icon: Icon(
                      Icons.close_sharp,
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
                                  ?.copyWith(fontSize: 20, color: Colors.white),
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
                                          color: Colors.white.withOpacity(0.6)),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 250.0, maxHeight: 45.0),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    canvasColor: colorScheme(context).tertiary,
                                    buttonTheme:
                                        ButtonTheme.of(context).copyWith(
                                      alignedDropdown: true,
                                    ),
                                  ),
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.1),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors.transparent),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                    ),
                                    value: 2,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text('Chọn phương thức...'),
                                      ),
                                      DropdownMenuItem(
                                          value: 0,
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons
                                                      .monetization_on_outlined,
                                                  color: Colors.white),
                                              SizedBox(width: 5.0),
                                              Text('Tiền mặt'),
                                            ],
                                          )),
                                      DropdownMenuItem(
                                          value: 1,
                                          child: Row(
                                            children: [
                                              Icon(Icons.credit_card,
                                                  color: Colors.white),
                                              SizedBox(width: 5.0),
                                              Text('Chuyển khoản'),
                                            ],
                                          )),
                                    ],
                                    onChanged: (item) => setState(() {
                                      selectedItem = item;
                                    }),
                                  ),
                                )),
                            const SizedBox(
                              width: 30.0,
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
                      ],
                    ),
                  ),
                ),
                LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  double maxWidth = constraints.maxWidth;
                  int columns;
                  if (maxWidth > mobileWidth) {
                    if (maxWidth > tabletWidth) {
                      columns = 3; // PC
                    } else {
                      columns = 2; // Tablet
                    }
                  } else {
                    columns = 1; // Mobile
                  }
                  return BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) {
                      print(
                          "has new data: param: ${widget.tableID} state: ${prdBloc.state.tableId}");
                      return widget.tableID == prdBloc.state.tableId;
                    },
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
                        return GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            childAspectRatio: (maxWidth / columns) / 80,
                          ),
                          itemCount: state.currentProducts!.toSet().length,
                          itemBuilder: (context, index) {
                            Product product = state.currentProducts![index];
                            int quantityProduct = product.quantity ?? 1;
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
                                                onTap: () {
                                                  context.read<OrderBloc>().add(
                                                      OnUpdateProductQuantity(
                                                          productID: product.id,
                                                          type:
                                                              TypeUpdateQuantity
                                                                  .decrement,
                                                          tableID:
                                                              widget.tableID));
                                                },
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
                                                onTap: () {
                                                  print(
                                                      "PRD ID: ${product.id}");
                                                  context.read<OrderBloc>().add(
                                                      OnUpdateProductQuantity(
                                                          productID: product.id,
                                                          type:
                                                              TypeUpdateQuantity
                                                                  .increment,
                                                          tableID:
                                                              widget.tableID));
                                                },
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
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomActionBill extends StatelessWidget {
  const BottomActionBill(
      {super.key,
      required this.tableId,
      this.selectedItem,
      required this.amount});

  final int tableId;
  final int? selectedItem;
  final int amount;

  _showDialog(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: colorScheme(context).onPrimary.withOpacity(0.6),
            surfaceTintColor: Colors.transparent,
            title: const Center(
              child: Icon(
                Icons.report_gmailerrorred_outlined,
                size: 60,
                color: Colors.red,
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  content,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 15),
                ),
              ],
            ),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 10.0),
                        child: Text('ĐÓNG',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                      )),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    bool isMobile = checkDevice(widthOfScreen, true, false, false);
    int price = 0;
    return Container(
        decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 0.0,
              offset: const Offset(0, 1.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                        price = 0;
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
              height: 4,
            ),
            Row(
              children: isMobile
                  ? <Widget>[
                      Expanded(
                        child: MyOutlineButton(
                          text: 'Quay lại',
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyButtonGradient(
                          text: "Thanh toán",
                          onTap: () {
                            if (amount == 0) {
                              _showDialog(context, 'Vui lòng chọn món.');
                            } else if (selectedItem == 2) {
                              _showDialog(context,
                                  'Vui lòng chọn phương thức thanh toán.');
                            } else {
                              context.read<OrderBloc>().add(PayBillEvent(
                                    tableId: tableId,
                                    payMethod: selectedItem ?? 0,
                                    pushScreen: (payStatus, billData) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaySuccessScreen(
                                            payStatus: payStatus,
                                            billData: billData,
                                            price: price,
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            }
                          },
                        ),
                      ),
                    ]
                  : <Widget>[
                      const Spacer(),
                      SizedBox(
                        width: 200,
                        child: MyOutlineButton(
                          text: 'Quay lại',
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: MyButtonGradient(
                          text: "Thanh toán",
                          onTap: () {
                            if (amount == 0) {
                              _showDialog(context, 'Vui lòng chọn món.');
                            } else if (selectedItem == 2) {
                              _showDialog(context,
                                  'Vui lòng chọn phương thức thanh toán.');
                            } else {
                              context.read<OrderBloc>().add(PayBillEvent(
                                    tableId: tableId,
                                    payMethod: selectedItem ?? 0,
                                    pushScreen: (payStatus, billData) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PaySuccessScreen(
                                            payStatus: payStatus,
                                            billData: billData,
                                            price: price,
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                            }
                          },
                        ),
                      ),
                    ],
            ),
          ],
        ));
  }
}
