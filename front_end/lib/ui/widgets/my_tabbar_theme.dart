import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:restaurant_manager_app/main.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class MyTabBarTheme extends StatefulWidget {
  const MyTabBarTheme({
    super.key,
  });

  @override
  State<MyTabBarTheme> createState() => _MyTabBarThemeState();
}

class _MyTabBarThemeState extends State<MyTabBarTheme>
    with TickerProviderStateMixin {
  int pos = 0;

  @override
  void initState() {
    MySharePreferences.getIsDarkTheme().then((value) {
      setState(() {
        pos = value ?? false ? 1 : 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        color: colorScheme(context).tertiary.withOpacity(0.3),
        child: TabBar(
            onTap: (value) async {
              await Future.delayed(200.ms);
              await MySharePreferences.setIsDarkTheme(value == 1);
              if (value == 1) {
                MyApp.themeNotifier.value = ThemeMode.dark;
              } else {
                MyApp.themeNotifier.value = ThemeMode.light;
              }
              setState(() {
                pos = value;
              });
            },
            labelColor: colorScheme(context).scrim,
            padding: const EdgeInsets.all(4),
            splashBorderRadius: BorderRadius.circular(8),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorScheme(context).onPrimary),
            indicatorSize: TabBarIndicatorSize.tab,
            controller:
                TabController(length: 2, vsync: this, initialIndex: pos),
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [Icon(Icons.light_mode), Text("Sáng", style: TextStyle(
                    fontSize: 14
                  ),)],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(Icons.dark_mode), Text("Tối", style: TextStyle(
                    fontSize: 14
                  ))],
                ),
              ),
            ]),
      ),
    );
  }
}
