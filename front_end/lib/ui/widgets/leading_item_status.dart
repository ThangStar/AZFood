import 'package:flutter/material.dart';

class LeadingItemStatus extends StatelessWidget {
  const LeadingItemStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            width: 10,
            height: 10,
            color: Colors.red,
          ),
        ),
         Expanded(
           child: Container(
              width: 1,
              height: 20,
              color: Colors.red,
            ),
         ),
      ],
    );
  }
}