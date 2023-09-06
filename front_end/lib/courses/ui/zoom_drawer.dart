import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

final ZoomDrawerController z = ZoomDrawerController();

class Zoom extends StatefulWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<Zoom> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      showShadow: true,
      menuBackgroundColor: Colors.blue,
      mainScreen: const Body(),
      angle: -10,
      // moveMenuScreen: false,
      menuScreen: Scaffold(
        appBar: AppBar(
          title: Text("a"),
          actions: [IconButton(onPressed: () {
            z.close!();
          }, icon: Icon(Icons.close))],
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              final navigator = Navigator.of(
                context,
              );
            },
            child: const Text(
              "Content Page",
              style: TextStyle(fontSize: 24.0, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.read_more),
          onPressed: () {
            z.open!();
          },
        ),
        title: Text("MAIN"),
      ),
    );
  }
}
