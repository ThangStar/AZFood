import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ResetPasswordSuccess) {
          showMySnackBar(context, state.response['message'].toString(),
              TypeSnackBar.success);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else if (state is ResetPasswordFailed) {
          showMySnackBar(context, state.response['message'].toString(),
              TypeSnackBar.error);
        }else if (state is ResetPasswordErorr) {
          showMySnackBar(context, 'Đã xảy ra lỗi, vui lòng thử lại',
              TypeSnackBar.error);
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
                                                  child:
                                                      Text("Đặt lại mật khẩu"),
                                                ),
                                                MyTextField(
                                                  validator: (p0) {
                                                    bool isEmail = RegExp(
                                                        r"^[a-zA-Z0-9]{5,12}$")
                                                        .hasMatch(p0!);
                                                    return isEmail
                                                        ? null
                                                        : "Mật khẩu không chứa kí tự đặc biệt, 5-12 kí tự";
                                                  },
                                                  isShowPass: isShowPass,
                                                  hintText:
                                                      "Nhập mật khẩu mới của bạn",
                                                  icon: const Icon(
                                                      Icons.password),
                                                  label: "Password",
                                                  controller:
                                                      resetPassController,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                MyTextField(
                                                  validator: (p0) {
                                                    bool isEmail = RegExp(
                                                        r"^[a-zA-Z0-9]{5,12}$")
                                                        .hasMatch(p0!);
                                                    return isEmail
                                                        ? null
                                                        : "Mật khẩu không chứa kí tự đặc biệt, 5-12 kí tự";
                                                  },
                                                  isShowPass: isShowPass,
                                                  hintText:
                                                      "Xác nhận mật khẩu của bạn",
                                                  icon: const Icon(
                                                      Icons.password),
                                                  label: "Verify Password",
                                                  controller:
                                                      verifyPassController,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _onChangeShowPass();
                                                  },
                                                  child: const Text(
                                                    'Hiện mật khẩu',
                                                    style: TextStyle(color: Colors.blue),
                                                  ),
                                                )
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
                                                  value: "Đổi mật khẩu",
                                                  onPressed: () {
                                                    if(resetPassController.text == verifyPassController.text){
                                                      BlocProvider.of<
                                                          ForgotPasswordBloc>(
                                                          context)
                                                          .add(
                                                        ResetPasswordEvent(
                                                            password:
                                                            resetPassController
                                                                .text,),
                                                      );
                                                    }else{
                                                      showMySnackBar(context, 'Mật khẩu không trùng khớp',
                                                          TypeSnackBar.error);
                                                    }
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
