import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_snack_bar.dart';
import 'package:restaurant_manager_app/ui/widgets/my_alert.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_check_box.dart';
import 'package:restaurant_manager_app/ui/widgets/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool isShowPass;
  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");

  String messageErr = '';
  TypeAlert typeMessageErr = TypeAlert.error;

  bool cbxSaveLogin = false;
  bool isShowAlert = false;
  bool isValid = false;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isShowPass = false;
    _fillDataForm();
  }

  void _onChangeSaveLogin(bool value) {
    setState(() {
      cbxSaveLogin = value;
    });
  }

  void _fillDataForm() async {
    LoginResponse? rs = await MySharePreferences.loadProfile();
    print(rs);
    if (rs != null) {
      usernameController.text = rs.username;
    }
  }

  void _onChangeShowPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          showMySnackBar(context, "Đăng nhập thành công", TypeSnackBar.success);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeMenuScreen(),
              ));
        } else if (state is AuthLoginFailed) {
          setState(() {
            isShowAlert = true;
            messageErr = "Tài khoản hoặc mật khẩu không chính xác";
            typeMessageErr = TypeAlert.error;
          });
        } else if (state is AuthLoginConnectionFailed) {
          setState(() {
            isShowAlert = true;
            messageErr = "Mất kết nối đến máy chủ";
            typeMessageErr = TypeAlert.warming;
          });
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme(context).background,
        body: Container(
          color: colorScheme(context).background.withOpacity(0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: colorScheme(context).tertiary),
                      color: colorScheme(context).onPrimary),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Form(
                    onChanged: () {
                      if (_keyForm.currentState != null) {
                        print(_keyForm.currentState!.validate());
                        setState(() {
                          isValid = _keyForm.currentState!.validate();
                        });
                      }
                    },
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/logo.svg',
                              width: 40,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "ĐĂNG NHẬP",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        MyAlert(
                          height: isShowAlert ? null : 0,
                          icon: Icons.warning_rounded,
                          title: "Thông báo",
                          message: messageErr,
                          typeAlert: typeMessageErr,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4),
                              child: Text("Tên tài khoản"),
                            ),
                            MyTextField(
                              validator: (p0) {
                                bool isEmail = RegExp(r"^[a-zA-Z0-9]{5,12}$")
                                    .hasMatch(p0!);
                                return isEmail
                                    ? null
                                    : "Tài khoản không chứa kí tự đặc biệt, 5-12 kí tự";
                              },
                              onChanged: (p0) {
                                if (isShowAlert) {
                                  setState(() {
                                    isShowAlert = false;
                                  });
                                }
                              },
                              hintText: "Nhập tài khoản",
                              icon: const Icon(Icons.person),
                              label: "Tài khoản",
                              controller: usernameController,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4, top: 12),
                              child: Text("Mật khẩu"),
                            ),
                            MyTextField(
                              validator: (p0) {
                                bool isEmail = RegExp(r"^[a-zA-Z0-9]{5,12}$")
                                    .hasMatch(p0!);
                                return isEmail
                                    ? null
                                    : "Mật khẩu không chứa kí tự đặc biệt, 5-12 kí tự";
                              },
                              onChanged: (p0) {
                                if (isShowAlert) {
                                  setState(() {
                                    isShowAlert = false;
                                  });
                                }
                              },
                              isShowPass: isShowPass,
                              label: "Mật khẩu",
                              controller: passwordController,
                              hintText: "Nhập mật khẩu",
                              icon: IconButton(
                                  icon: Icon(isShowPass
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: _onChangeShowPass),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                MyCheckBox(
                                  value: cbxSaveLogin,
                                  onChanged: (p0) => _onChangeSaveLogin(p0!),
                                ),
                                const Text('Ghi nhớ đăng nhập')
                              ],
                            ),
                            const Text(
                              'Quên mật khẩu',
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Hero(
                            tag: "login_hero",
                            child: MyButton(
                              disable: !isValid,
                              value: "Đăng nhập",
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  authBloc.add(LoginAutEvent(
                                      username: usernameController.text,
                                      password: passwordController.text));
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
                                  color: colorScheme(context)
                                      .scrim
                                      .withOpacity(0.6)),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
