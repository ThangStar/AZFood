import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class NotificationNews extends StatelessWidget {
  const NotificationNews({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
        padding: const EdgeInsets.all(10),
        color: colorScheme(context).primary.withOpacity(0.1),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 1),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RichText(
                softWrap: false,
                text: const TextSpan(
                  text: "Thông báo: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFF1573FE)),
                  children: <TextSpan>[
                    TextSpan(text: 'Món ', style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: 'Trứng sốt cà chua ',
                        style: TextStyle(color: Colors.redAccent)),
                    TextSpan(
                        text: 'đã hết vui lòng thông báo với khách hàng để đặt món mới.',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              )
                  .animate(onComplete: (controller) => controller.repeat(),)
                  .fade(duration: 600.ms)
                  .moveX(begin: width, duration: 5.seconds).then().moveX(end: -width, duration: 5.seconds),
            ),
          ),
        ));
  }
}
