import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/screens/splash_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/theme/text_theme.dart';
import 'package:restaurant_manager_app/utils/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme, textTheme: textTheme),
      // darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const SplashScreen(),
    );
  }
}
