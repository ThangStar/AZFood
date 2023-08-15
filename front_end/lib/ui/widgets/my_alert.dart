import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyAlert extends StatelessWidget {
  const MyAlert({
    super.key,
    required this.icon,
    required this.title,
    required this.message, this.height,
  });

  final IconData icon;
  final String title;
  final String message;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme(context).error,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      duration: 200.ms,
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
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorScheme(context).onError,),
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme(context).onError.withOpacity(0.8)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
