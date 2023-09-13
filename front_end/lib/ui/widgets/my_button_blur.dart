import 'dart:ui';

import 'package:flutter/material.dart';

class MyButtonBlur extends StatelessWidget {
  const MyButtonBlur({super.key, required this.text, required this.onTap});
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(text, style: const TextStyle(
                  color: Colors.white
                ),))),
        ),
      ),
    );
  }
}
