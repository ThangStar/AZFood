import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';

import '../../blocs/forgot_pass/forgot_password_bloc.dart';
import '../../theme/color_schemes.dart';
import '../../utils/my_snack_bar.dart';
import '../../utils/size_config.dart';
import '../../widgets/my_alert.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late bool isShowPass;
  final TextEditingController resetPassController =
      TextEditingController(text: "");
  final TextEditingController verifyPassController =
      TextEditingController(text: "");
  String messageErr = '';
  TypeAlert typeMessageErr = TypeAlert.error;

  bool isValid = false;

  @override
  void initState() {
    super.initState();
    isShowPass = false;
    _fillDataForm();
  }

  void _fillDataForm() async {
    if (!isValid) {
      setState(() {
        isValid = true;
      });
    }

    if (isValid) {
      setState(() {
        isValid = false;
      });
    }
  }

  void _onChangeShowPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  bool isEnablePassword = false;
  bool isEnableConfirmPassword = false;
  bool isPassword = false;
  bool isConfirmPassword = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          myAlert(context, checkDeviceType(size.width), AlertType.success,
                "Thông báo", state.response['message'].toString())
            .show(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else if (state is ResetPasswordFailed) {
          myAlert(context, checkDeviceType(size.width), AlertType.error,
                "Thông báo", state.response['message'].toString())
            .show(context);
        } else if (state is ResetPasswordErorr) {
          myAlert(context, checkDeviceType(size.width), AlertType.error,
                "Thông báo", 'Đã xảy ra lỗi, vui lòng thử lại')
            .show(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: colorScheme(context).onPrimary,
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
                                                  padding: EdgeInsets.only(
                                                      bottom: 4),
                                                  child: Text("Mật khẩu mới"),
                                                ),
                                                MyTextField(
                                                  onChanged: (p0) {
                                                    setState(() {
                                                      isPassword;
                                                      isEnablePassword = true;
                                                      print(
                                                          "${isEnablePassword}");
                                                    });
                                                  },
                                                  validator: (value) {
                                                    isPassword = RegExp(
                                                            r"^[a-zA-Z0-9]{5,12}$")
                                                        .hasMatch(value!);
                                                    return isPassword
                                                        ? null
                                                        : "Mật khẩu không chứa kí tự đặc biệt, 5-12 kí tự.";
                                                  },
                                                  hintText:
                                                      "Nhập mật khẩu mới của bạn",
                                                  icon: const Icon(
                                                      Icons.password),
                                                  controller:
                                                      resetPassController,
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 4.0),
                                                  child:
                                                      Text("Nhập lại mật khẩu"),
                                                ),
                                                MyTextField(
                                                  onChanged: (p0) {
                                                    setState(() {
                                                      isConfirmPassword;
                                                      isEnableConfirmPassword =
                                                          true;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    isConfirmPassword = RegExp(
                                                            r"^[a-zA-Z0-9]{5,12}$")
                                                        .hasMatch(value!);
                                                    if (!isConfirmPassword) {
                                                      return "Mật khẩu không chứa kí tự đặc biệt, 5-12 kí tự.";
                                                    } else if (value !=
                                                        resetPassController
                                                            .text) {
                                                      return "Mật khẩu không khớp với mật khẩu trên.";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  hintText:
                                                      "Xác nhận mật khẩu của bạn",
                                                  icon: const Icon(
                                                      Icons.password),
                                                  controller:
                                                      verifyPassController,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 26,
                                            ),
                                            Hero(
                                                tag: "login_hero",
                                                child: MyButton(
                                                  value: "Đổi mật khẩu",
                                                  disable: !(isEnablePassword && isEnableConfirmPassword && isPassword && isConfirmPassword && (resetPassController.text == verifyPassController.text)),
                                                  onPressed: () {
                                                    BlocProvider.of<ForgotPasswordBloc>(context).add(
                                                      ResetPasswordEvent(
                                                        password:resetPassController.text
                                                      ),
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
                                                      color: colorScheme(
                                                              context)
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
          )),
    );
  }
}
