import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/model/product_booking.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/leading_item_status.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, required this.productBooking});
  final ProductBooking productBooking;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        onTap: () {},
        leading: SizedBox(
          width: 100,
          height: 100,
          child: Row(
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
                    productBooking.image,
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
              "${productBooking.name} - ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              productBooking.type,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: colorScheme(context).primary),
            )
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              productBooking.amount == 0
                  ? const Icon(
                      Icons.error,
                      size: 18,
                      color: Colors.redAccent,
                    )
                  : const SizedBox.shrink(),
              Container(
                decoration: productBooking.amount == 0
                    ? null
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Color(0xFF049C6B),
                      ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  productBooking.amount == 0
                      ? " Hết hàng"
                      : " ${productBooking.amount}",
                  style: TextStyle(
                      color:
                          productBooking.amount == 0 ? Colors.red : Colors.white),
                ),
              )
            ],
          ),
        ),
        trailing: Text(
          "${NumberFormat.decimalPattern().format(productBooking.money)} đ",
        ),
      ),
    );
  }
}
