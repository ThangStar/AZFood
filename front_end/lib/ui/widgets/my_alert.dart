import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

enum TypeAlert { warming, error, info }

class MyAlert extends StatelessWidget {
  const MyAlert({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.height,
    this.typeAlert = TypeAlert.error,
  });

  final IconData icon;
  final String title;
  final String message;
  final double? height;
  final TypeAlert typeAlert;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 200.ms,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: typeAlert == TypeAlert.error
              ? colorScheme(context).error :
              typeAlert == TypeAlert.info ?
              colorScheme(context).primary
              : Colors.yellow[900],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorScheme(context).onError,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme(context).onError,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme(context).onError.withOpacity(0.8)),
                  softWrap: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
