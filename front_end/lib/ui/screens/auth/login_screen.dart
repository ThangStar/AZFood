import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController txtUsername = TextEditingController(text: '');
    final TextEditingController txtPassword = TextEditingController();

    return Scaffold(
      backgroundColor: colorScheme(context).background,
      body: Container(
        color: colorScheme(context).tertiary.withOpacity(0.3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        width: 1, color: colorScheme(context).tertiary),
                    color: colorScheme(context).background),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svgs/logo.svg'),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "ĐĂNG NHẬP",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    MyTextField(
                      hintText: "Nhập tài khoản", icon: Icon(Icons.person_outline),
                      label: "Tài khoản",
                      controller: txtUsername,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    MyTextField(
                      obscureText: true,
                      label: "Mật khẩu",
                      controller: txtPassword,
                      hintText: "Nhập mật khẩu", icon: Icon(Icons.lock_outline_rounded),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Hero(
                        tag: "login_hero",
                        child: MyButton(
                          value: "Đăng nhập",
                          onPressed: () {},
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
