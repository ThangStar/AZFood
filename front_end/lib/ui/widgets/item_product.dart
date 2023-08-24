import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/product.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/leading_item_status.dart';

//  Text
//("${NumberFormat.decimalPattern().format(product.money)} đ"),

class ItemProduct extends StatelessWidget {
  const ItemProduct(
      {super.key,
      required this.product,
      required this.subTitle,
      required this.trailling});
  final Product product;
  final Widget subTitle;
  final Widget trailling;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      onTap: () {},
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  product.imageUrl ??
                      "https://yt3.googleusercontent.com/ytc/AOPolaQWGbDFvkId2pquCOeGl2yr_gCBFufxLNW9Z6fg3A=s900-c-k-c0x00ffffff-no-rj",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      title: Row(
        children: [
          Text(
            "${product.name} - ",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "${product.category}",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: colorScheme(context).primary),
          )
        ],
      ),
      subtitle: subTitle,
      trailing: trailling,
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
                    color: Color(0xFF049C6B),
                  ),
            padding: product.quantity != 0
                ? EdgeInsets.symmetric(horizontal: 12, vertical: 6)
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme(context).primary, fontWeight: FontWeight.bold),
        ));
  }
}
