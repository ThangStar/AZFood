import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class KeyBoardIcon extends StatelessWidget {
  const KeyBoardIcon({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 30,
      height: 22,
      decoration: BoxDecoration(
        color: colorScheme(context).scrim.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 2, color: colorScheme(context).scrim.withOpacity(0.6))),
      child: Center(
          child: FittedBox(
              child: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme(context).scrim.withOpacity(0.6)),
      ))),
    );
  }
}
