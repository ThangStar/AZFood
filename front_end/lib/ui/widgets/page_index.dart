import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class PageIndex extends StatelessWidget {
  const PageIndex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              children: [
                ClipOval(
                  child: Container(
                    width: 12,
                    height: 12,
                    color: const Color(0xFF1573FE),
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 18,
                    height: 18,
                    color: const Color(0xFF1573FE).withOpacity(0.2),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              "Trang hiện tại",
              style:
                  TextStyle(color: colorScheme(context).scrim.withOpacity(0.6)),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: colorScheme(context).primary.withOpacity(0.1),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: Text(
                "1",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: colorScheme(context).primary),
              ),
            ),
          ),
        )
      ],
    );
  }
}
