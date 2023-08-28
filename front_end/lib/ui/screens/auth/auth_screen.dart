import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';

import '../../utils/my_bottom_sheet.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/logo.svg', width: 40),
                  const SizedBox(width: 10,),
                  Text('Bloc App', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ))
                ],
              ),
              Column(
                children: [
                  Text(
                    "Smart Restaurant",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  SvgPicture.asset(
                      width: sizeScreen.width,
                      height: sizeScreen.height * 0.4,
                      'assets/svgs/person_pay.svg'),
                ],
              ),
              Hero(
                transitionOnUserGestures: true,
                tag: "login_hero",
                child: MyButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => const LoginScreen(),
                          ));
                    },
                    value: "ĐĂNG NHẬP"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
