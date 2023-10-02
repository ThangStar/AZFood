import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key, required this.icon, required this.onPressed, this.color, this.backgroundColor});

  final Widget icon;
  final Function() onPressed;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? colorScheme(context).tertiary.withOpacity(0.6),
      child: IconButton(
          color: color ?? colorScheme(context).scrim.withOpacity(0.6),
          onPressed: onPressed,
          icon: icon),
    );
  }
}
