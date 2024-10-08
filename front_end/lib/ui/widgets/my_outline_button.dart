import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyOutlineButton extends StatelessWidget {
  const MyOutlineButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.padding = const EdgeInsets.symmetric(vertical: 14)});
  final String text;
  final Function() onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: colorScheme(context).onPrimary,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme(context).tertiary),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: padding,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                  color: colorScheme(context).primary, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
