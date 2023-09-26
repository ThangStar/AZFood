import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import '../../theme/color_schemes.dart';
import '../../utils/size_config.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class FogetPasswordScreen extends StatefulWidget {
  const FogetPasswordScreen({super.key});

  @override
  State<FogetPasswordScreen> createState() => _FogetPasswordScreenState();
}

class _FogetPasswordScreenState extends State<FogetPasswordScreen> {
  final TextEditingController fogetPassController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme(context).onSecondary,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme(context).scrim,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: colorScheme(context).background.withOpacity(0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: colorScheme(context).tertiary),
                              color: colorScheme(context).onPrimary),
                          margin: EdgeInsets.symmetric(
                              horizontal: checkDevice(
                                  constraints.maxWidth, 16.0, 18.0, 186.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              checkDevice(
                                  constraints.maxWidth,
                                  const SizedBox.shrink(),
                                  const Expanded(
                                      flex: 1, child: LeadContentLogin()),
                                  const Expanded(
                                      flex: 1, child: LeadContentLogin())),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 24),
                                  child: Form(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            checkDevice(
                                                constraints.maxWidth,
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/chicken.png',
                                                      width: 40,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox.shrink(),
                                                const SizedBox.shrink()),
                                            Text(
                                              "QUÊN MẬT KHẨU",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Text(
                                                  "Email khôi phục tài khoản"),
                                            ),
                                            MyTextField(
                                              hintText: "Nhập email của bạn",
                                              icon: const Icon(Icons.email),
                                              label: "email",
                                              controller: fogetPassController,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Hero(
                                            tag: "login_hero",
                                            child: MyButton(
                                              value: "Lấy mã xác nhận",
                                              onPressed: () {},
                                            )),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        const Divider(),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "Bloc App",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: colorScheme(context)
                                                      .scrim
                                                      .withOpacity(0.6)),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
