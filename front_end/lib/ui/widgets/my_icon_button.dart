import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton({super.key, required this.icon, required this.onPressed});
  final Widget icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorScheme(context).tertiary.withOpacity(0.6),
      child: IconButton(
          color: colorScheme(context).scrim.withOpacity(0.6),
          onPressed: onPressed,
          icon: icon),
    );
  }
}
