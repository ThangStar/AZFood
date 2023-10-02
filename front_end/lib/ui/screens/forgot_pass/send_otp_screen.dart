import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/forgot_pass/forgot_pass_screen.dart';

import '../../blocs/forgot_pass/forgot_password_bloc.dart';
import '../../theme/color_schemes.dart';
import '../../utils/my_snack_bar.dart';
import '../../utils/size_config.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../auth/login_screen.dart';

class SendOTPScreen extends StatefulWidget {
  const SendOTPScreen({Key? key}) : super(key: key);

  @override
  State<SendOTPScreen> createState() => _SendOTPScreenState();
}

class _SendOTPScreenState extends State<SendOTPScreen> {
  final TextEditingController sendOTPController =
  TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is SendEmailSuccess){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SendOTPScreen()),
          );
          showMySnackBar(context, state.status, TypeSnackBar.success);
        }else if(state is SendEmailFailed){
          showMySnackBar(context, state.status, TypeSnackBar.error);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: colorScheme(context).onSecondary,
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
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
                                       Expanded(
                                          flex: 1, child: LeadContentLogin()),
                                       Expanded(
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
                                                  style: Theme
                                                      .of(context)
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
                                                      "Mã OTP khôi phục mật khẩu"),
                                                ),
                                                MyTextField(
                                                  hintText: "Nhập mã OTP của bạn",
                                                  icon: const Icon(Icons.qr_code_2),
                                                  label: "OTP từ email",
                                                  controller: sendOTPController,
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
                                                  value: "Xác nhận OTP",
                                                  onPressed: () {
                                                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                                                      SendEmailEvent(email: sendOTPController.text),
                                                    );
                                                  },
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
          )
      ),
    );
  }
}
