import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.onPressed,
    this.value,
    this.isOutline = false,
  }) : super(key: key);

  final Function() onPressed;
  final String? value;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: isOutline
                  ? [
                colorScheme(context).background,
                colorScheme(context).background,
              ]
                  : [
                const Color(0XFF4776E6),
                const Color(0XFF8E54E9)
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: isOutline
                ? Border.all(color: colorScheme(context).tertiary, width: 1)
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
          child: Text(
            value ?? "Button",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isOutline
                  ? colorScheme(context).scrim
                  : colorScheme(context).onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
