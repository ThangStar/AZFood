import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyChipToggle extends StatelessWidget {
  const MyChipToggle(
      {super.key,
      required this.isSelected,
      required this.label,
      required this.color,
      required this.onTap});
  final bool isSelected;
  final String label;
  final Color? color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        side: BorderSide(
            color: isSelected
                ? colorScheme(context).primary.withOpacity(0.1)
                : colorScheme(context).tertiary.withOpacity(0.3)),
        label: Row(
          children: [
            if (color != null) ...[
              Container(
                width: 10,
                height: 10,
                color: color,
              ),
              const SizedBox(width: 5.0),
            ],
            Text(
              label,
              style: TextStyle(
                  color: isSelected
                      ? colorScheme(context).onPrimary
                      : colorScheme(context).scrim.withOpacity(0.8)),
            ),
          ],
        ),
        backgroundColor: isSelected
            ? colorScheme(context).primary
            : colorScheme(context).onPrimary,
      ),
    );
  }
}
