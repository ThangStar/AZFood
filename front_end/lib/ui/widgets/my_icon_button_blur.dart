import 'dart:ui';

import 'package:flutter/material.dart';

class MyIconButtonBlur extends StatelessWidget {
  const MyIconButtonBlur({super.key, required this.icon, required this.onTap});
  final Widget icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                radius: 8,
                onTap: onTap,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.black.withOpacity(0.2)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: icon,
                ),
              ),
            ),
          )),
    ]);
  }
}

class FrostedDemo extends StatelessWidget {
  const FrostedDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const FlutterLogo(size: 1000),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.5)),
                  child: Center(
                    child: Text('Frosted',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
