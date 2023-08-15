import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/widgets/my_icon_button_blur.dart';

class MyToolbar extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? trailling;
  final String? title;
  final Widget? content;
  const MyToolbar({
    super.key,
    this.leading,
    this.trailling,
    this.title, this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background.jpg')),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0), Colors.black]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leading ?? const SizedBox.shrink(),
                  Text(title ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white)),
                  trailling?[0] ?? const SizedBox.shrink()
                ],
              ),
            ),
            content ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
