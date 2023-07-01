import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, required this.onPressed, this.value, this.isOutline = false});

  final Function() onPressed;
  final String? value;
  final bool isOutline;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: isOutline ? BorderSide(
              width: 1, color: colorScheme(context).tertiary) : BorderSide
              .none),
      color: isOutline
          ? colorScheme(context).background
          : colorScheme(context).secondary,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap:onPressed,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            width: double.infinity,
            child: Text(
              textAlign: TextAlign.center,
              value ?? "Button",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                  color: isOutline ? colorScheme(context).scrim : colorScheme(
                      context).background),
            )),
      ),
    );
  }
}



