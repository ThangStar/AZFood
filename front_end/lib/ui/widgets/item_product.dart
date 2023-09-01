import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/leading_item_status.dart';
import 'package:restaurant_manager_app/utils/get_pos_by_key.dart';

//  Text
//("${NumberFormat.decimalPattern().format(product.money)} đ"),

class ItemProduct extends StatefulWidget {
  ItemProduct(
      {super.key,
      required this.product,
      required this.subTitle,
      required this.trailling,
      this.cartKey,
      this.onTap});
  final Product product;
  final Widget subTitle;
  final Widget trailling;
  final Function()? onTap;
  final GlobalKey? cartKey;
  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct>
    with TickerProviderStateMixin {
  bool isSelected = false;
  GlobalKey key = GlobalKey();
  bool isInSideCart = false;
  late AnimationController moveController;
  late Animation moveAnimation;

  @override
  void initState() {
    moveController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    moveAnimation = moveAnimation = Tween(begin: 0.0, end: 100.0)
        .animate(moveController)
        .drive(CurveTween(curve: Curves.bounceInOut));
    super.initState();
  }

  @override
  void dispose() {
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, snapshot) {
        return Opacity(
          opacity:
              widget.product.quantity != 0 && widget.product.quantity != null
                  ? 1
                  : 0.6,
          child: ListTile(
            key: key,
            enabled:
                widget.product.quantity != 0 && widget.product.quantity != null,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            onTap: () {
              widget.onTap!();
              if (widget.cartKey != null && mounted) {
                final pos = getPositionbyKey(widget.cartKey!);
                moveAnimation = Tween(begin: 0.0, end: pos.y - 150).animate(
                    moveController
                        .drive(CurveTween(curve: Curves.bounceInOut)));

                print("X cart: ${pos.x} Y: ${pos.y}");
                moveController.forward();
              }
              setState(() {
                isInSideCart = !isInSideCart;
              });
            },
            leading: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LeadingItemStatus(),
                  const SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Transform.translate(
                      offset: Offset(0, moveAnimation.value),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          widget.product.imageUrl != null &&
                                  widget.product.imageUrl != ''
                              ? widget.product.imageUrl!
                              : "https://yt3.googleusercontent.com/ytc/AOPolaQWGbDFvkId2pquCOeGl2yr_gCBFufxLNW9Z6fg3A=s900-c-k-c0x00ffffff-no-rj",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            title: Row(
              children: [
                Text(
                  "${widget.product.name} - ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "${widget.product.category}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).primary),
                )
              ],
            ),
            subtitle: widget.subTitle,
            trailing: widget.trailling,
            tileColor: isSelected ? Colors.amber : null,
          ),
        );
      },
      animation: moveAnimation,
    );
  }
}

class SubTitleItemProduct extends StatelessWidget {
  const SubTitleItemProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          product.quantity == 0
              ? const Icon(
                  Icons.error,
                  size: 18,
                  color: Colors.redAccent,
                )
              : const SizedBox.shrink(),
          Container(
            decoration: product.quantity == 0
                ? null
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: const Color(0xFF049C6B),
                  ),
            padding: product.quantity != 0
                ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
                : null,
            child: Text(
              product.quantity == 0 ? " Hết hàng" : "${product.quantity}",
              style: TextStyle(
                  color: product.quantity == 0 ? Colors.red : Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class SubTitleItemCurrentBill extends StatelessWidget {
  const SubTitleItemCurrentBill({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          "${NumberFormat.decimalPattern().format(product.price)} đ",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: colorScheme(context).primary),
        ));
  }
}
