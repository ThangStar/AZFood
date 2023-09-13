import 'package:flutter/material.dart';

class MyButtonGradient extends StatelessWidget {
  const MyButtonGradient(
      {super.key,
      required this.text,
      required this.onTap,
      this.gradient = const LinearGradient(
          transform: GradientRotation(-300),
          colors: [Color(0xFF4776E6), Color(0xFF8E54E9)]),
      this.backgroundColor,
      this.radius, 
      this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16)});

  final String text;
  final Function() onTap;
  final Gradient? gradient;
  final Color? backgroundColor;
  final double? radius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 8),
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(gradient: gradient),
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: padding,
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
