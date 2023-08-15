import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';

class MyDialog extends StatelessWidget {
  const MyDialog(
      {super.key,
      this.title = "Hủy bàn?",
      this.content = "Thao tác này sẽ xóa toàn bộ sản phẩm khỏi bàn ",
      this.labelLeadingButton = "Xác nhận",
      this.isBackgroundDanger = true,
      this.labelTraillingButton = "Hủy",
      required this.onTapLeading,
      required this.onTapTrailling});
  final String title;
  final String content;
  final String labelLeadingButton;
  final bool isBackgroundDanger;
  final String labelTraillingButton;
  final Function() onTapLeading;
  final Function() onTapTrailling;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 1, color: colorScheme(context).tertiary)),
      contentPadding: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              width: double.infinity,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colorScheme(context).onPrimary.withOpacity(0.6),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        content,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              )),
                                padding: MaterialStatePropertyAll(
                                  EdgeInsets.all(18),
                                ),
                                side:
                                    MaterialStatePropertyAll(BorderSide.none)),
                            onPressed: onTapTrailling,
                            child: Text(
                              labelTraillingButton,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.8)),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          MyButtonGradient(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                            radius: 8,
                            backgroundColor: Colors.red,
                            text: labelLeadingButton,
                            gradient: null,
                            onTap: onTapLeading,
                          )
                        ],
                      )
                    ],
                  ))),
        ),
      ),
    );
  }
}
