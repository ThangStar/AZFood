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

    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset('assets/svgs/logo.svg')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: colorScheme(context).tertiary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
              child: Column(
                children: [
                  Text(
                    "NAME APP",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SvgPicture.asset(
                      width: sizeScreen.width,
                      height: sizeScreen.height * 0.4,
                      'assets/svgs/person_pay.svg'),
                ],
              ),
            ),
            Text(
              "Quản lí mọi thứ trên điện thoại của bạn",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: "login_hero",
                    child: MyButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, _, __) =>
                                    const LoginScreen(),
                              ));
                          // showMyBottomSheet(
                          //   context: context,
                          //   builder: (context) {
                          //     return LoginForm();
                          //   },
                          // );
                        },
                        value: "Đăng Nhập"),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  MyButton(
                    onPressed: () {
                      showMyBottomSheet(
                        context: context,
                        builder: (context) {
                          return RegisterForm();
                        },
                      );
                    },
                    value: "Đăng Kí",
                    isOutline: true,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget RegisterForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: const Column(
        children: [Text("ĐĂNG KÍ")],
      ),
    );
  }

  Widget LoginForm() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ĐĂNG NHẬP",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
