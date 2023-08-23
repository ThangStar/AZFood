import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/constants/key_storages.dart';
import 'package:restaurant_manager_app/model/login_result.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool cbxSaveLogin = false;
  bool isShowAlert = false;

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
    LoginResult? rs =
        await MySharePreferences.loadSavedData(KeyStorages.myProfile);
    if (rs != null) {
      passwordController.text = rs.username;
      // usernameController.text = ;
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } else if (state is AuthLoginFailed) {
          setState(() {
            isShowAlert = true;
          });
        }
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFFF8F6F4), Color(0XFFD2E9E9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 1.5, color: Colors.white),
                      color: Colors.white.withOpacity(0.2)),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                            width: 20,
                          ),
                          const Text(
                            "ĐĂNG NHẬP",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      MyAlert(
                        height: isShowAlert ? null : 0,
                        icon: Icons.warning_rounded,
                        title: "Thông báo",
                        message: "Tài khoản hoặc mật khẩu không chính xác",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
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
                      const SizedBox(
                        height: 15,
                      ),
                      MyTextField(
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
                              const Text('Lưu đăng nhập', style: TextStyle(fontSize: 16),)
                            ],
                          ),
                          const Text('Quên mật khẩu',  style: TextStyle(fontSize: 16, color: Colors.blue))
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Hero(
                          tag: "login_hero",
                          child: MyButton(
                            value: "Đăng nhập",
                            onPressed: () {
                              authBloc.add(LoginAutEvent(
                                  username: usernameController.text,
                                  password: passwordController.text));
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: Text(
                            "BloC App",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorScheme(context)
                                    .scrim
                                    .withOpacity(0.6)),
                          ))
                    ],
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
