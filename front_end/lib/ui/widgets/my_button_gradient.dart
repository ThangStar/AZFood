import 'package:flutter/material.dart';

class MyButtonGradient extends StatelessWidget {
  const MyButtonGradient({super.key, required this.text, required this.onTap});
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  transform: GradientRotation(-300),
                  colors: [Color(0xFF4776E6), Color(0xFF8E54E9)]),
            ),
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
