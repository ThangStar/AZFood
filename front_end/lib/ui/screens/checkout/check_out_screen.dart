import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/item_product.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, this.productsSelected = const []});
  final List<Product> productsSelected;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "check_out",
      child: Scaffold(
        backgroundColor: colorScheme(context).primary,
        appBar: AppBar(
          bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
              )),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme(context).onPrimary,
            ),
            onPressed: () {
              // Navigator.pop(context);
            },
          ),
          backgroundColor: colorScheme(context).surfaceTint,
          title: Text("Kiểm tra lại",
              style: TextStyle(
                  fontSize: 24, color: colorScheme(context).onPrimary)),
        ),
        bottomNavigationBar: const BottomActionBill(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme(context).onPrimary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary,
                    borderRadius: BorderRadius.circular(8)),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.productsSelected.length,
                  itemBuilder: (context, index) {
                    Product product = widget.productsSelected[index];
                    return ItemProduct(
                      hasIndicator: false,
                      product: product,
                      subTitle: SubTitleItemCurrentBill(product: product),
                      trailling: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: colorScheme(context)
                                          .primary
                                          .withOpacity(0.3)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      child: InkWell(
                                        onTap: () {
                                          if (widget.productsSelected[index]
                                                  .amountCart ==
                                              1) {
                                            setState(() {
                                              widget.productsSelected
                                                  .removeAt(index);
                                            });
                                          } else {
                                            Product productUpdate =
                                                widget.productsSelected[index];
                                            if (productUpdate.quantity !=
                                                null) {
                                              --productUpdate.amountCart;
                                            }
                                            setState(() {
                                              widget.productsSelected[index] =
                                                  productUpdate;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Icon(Icons.remove,
                                              color:
                                                  colorScheme(context).primary),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${product.amountCart}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme(context)
                                              .scrim
                                              .withOpacity(0.8)),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      child: InkWell(
                                        onTap: () {
                                          Product productUpdate =
                                              widget.productsSelected[index];
                                          if (productUpdate.quantity != null) {
                                            ++productUpdate.amountCart;
                                          }
                                          setState(() {
                                            widget.productsSelected[index] =
                                                productUpdate;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Icon(Icons.add,
                                              color:
                                                  colorScheme(context).primary),
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
                ),
              ),
            ),
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
        color: colorScheme(context).onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                MyOutlineButton(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  text: 'Quay lại',
                  onTap: () {
                    // Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyButtonGradient(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    text: "Xác nhận",
                    onTap: () {
                      // context.read<OrderBloc>().add(CreateOrderEvent(products: [
                      //       ProductCheckOut(
                      //           productID: 16, quantity: 1, tableID: 1),
                      //       ProductCheckOut(
                      //           productID: 17, quantity: 2, tableID: 1)
                      //     ]));
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }
}
