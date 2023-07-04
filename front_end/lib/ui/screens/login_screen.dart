import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home_sceen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button.dart';
import 'package:restaurant_manager_app/ui/widgets/my_check_box.dart';
import 'package:restaurant_manager_app/ui/widgets/my_text_field.dart';

import '../../constants/key_storages.dart';
import '../../storage/share_preferences.dart';

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
    passwordController.text =
        await MySharePreferences.loadSavedData(KeyStorages.keyPassword) ?? "";
    usernameController.text =
        await MySharePreferences.loadSavedData(KeyStorages.keyUsername) ?? "";
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
                builder: (context) => const HomeScreen(),
              ));
        }
      },
      child: Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/logo.svg'),
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
                        hintText: "Nhập tài khoản",
                        icon: const Icon(Icons.person),
                        label: "Tài khoản",
                        controller: usernameController,
                      ),
                      const SizedBox(
                        height: 6,
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
                      MyCheckBox(
                        value: cbxSaveLogin,
                        onChanged: (p0) => _onChangeSaveLogin(p0!),
                      ),
                      const SizedBox(
                        height: 8,
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
                        height: 16,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                          width: double.infinity,
                          child: Text(
                            "@name app",
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
