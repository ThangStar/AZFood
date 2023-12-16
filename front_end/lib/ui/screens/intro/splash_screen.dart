import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/screens/auth/auth_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorScheme(context).background,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/chicken.png', width: 230),
              const SizedBox(height: 80,),
              const SizedBox(
                  width: 180,
                  child: LinearProgressIndicator()),
              const SizedBox(height: 2,),
               Text("Đang tải..", style: Theme.of(context).textTheme.bodyLarge,)
            ],
          ),
        ),
      ),
    );
  }
}
