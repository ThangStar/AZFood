import 'package:flutter/material.dart';

class AspectRatioScreen extends StatelessWidget {
  const AspectRatioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aspect ratio"),
      ),
      body: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: AspectRatio(
              aspectRatio: 1 / 3,
              child: Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
