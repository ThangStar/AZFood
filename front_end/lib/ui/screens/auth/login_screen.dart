import 'dart:io';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_manager_app/constants/env.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/services/notification_mobile.dart';
import 'package:restaurant_manager_app/services/notification_window.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/forgot_pass/send_email_screen.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
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
      TextEditingController(text: "");
  String messageErr = '';
  TypeAlert typeMessageErr = TypeAlert.error;

  bool cbxSaveLogin = false;
  bool isValid = false;
  final _keyForm = GlobalKey<FormState>();
  late AuthenticationBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthenticationBloc>(context);
    isShowPass = true;
    _fillDataForm();
    _rememberMe();
  }

  void _onChangeSaveLogin(bool value) {
    setState(() {
      cbxSaveLogin = value;
    });
  }

  void _fillDataForm() async {
    LoginResponse? rs = await MySharePreferences.loadProfile();
    print(rs?.toJson());
    if (rs != null) {
      usernameController.text = rs.username;
      if (rs.password != "") {
        if (!isValid) {
          setState(() {
            isValid = true;
          });
        }
        passwordController.text = rs.password ?? "";
      } else {
        if (isValid) {
          setState(() {
            isValid = false;
          });
        }
      }
    }
  }

  void _onChangeShowPass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  void _rememberMe() async {
    bool rememberMe = await MySharePreferences.getRememberMe() ?? false;
    setState(() {
      cbxSaveLogin = rememberMe;
    });
    print("rememberME: $rememberMe");

    if (rememberMe) {
      authBloc.add(LoginAutEvent(
          username: usernameController.text,
          password: passwordController.text));
    }
  }

  void _btnLogin() {
    print("cbxSaveLogin: $cbxSaveLogin");
    MySharePreferences.setRememberMe(cbxSaveLogin);
    if (_keyForm.currentState?.validate() ?? false) {
      authBloc.add(LoginAutEvent(
          username: usernameController.text,
          password: passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerIpv4 = TextEditingController();

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) {
          myAlert(context, checkDeviceType(MediaQuery.of(context).size.width),
                  AlertType.success, "Thông báo", "Đăng nhập thành công")
              .show(context);

          // showMySnackBar(context, "Đăng nhập thành công", TypeSnackBar.success);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeMenuScreen(),
              ));
        } else if (state is AuthLoginFailed) {
          ElegantNotification.error(
                  title: const Text("Thông báo"),
                  description:
                      const Text("Tài khoản hoặc mật khẩu không chính xác"))
              .show(context);
          // setState(() {
          //   isShowAlert = true;
          //   messageErr = "Tài khoản hoặc mật khẩu không chính xác";
          //   typeMessageErr = TypeAlert.error;
          // });
        } else if (state is AuthLoginConnectionFailed) {
          ElegantNotification.error(
                  title: const Text("Thông báo"),
                  description: const Text("Mất kết nối máy chủ"))
              .show(context);
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme(context).background,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: colorScheme(context).background.withOpacity(0.3),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ActionTest(
                    //   controllerIpv4: controllerIpv4,
                    // ),
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
                                      onChanged: () {
                                        if (_keyForm.currentState != null) {
                                          print(_keyForm.currentState!
                                              .validate());
                                          setState(() {
                                            isValid = _keyForm.currentState!
                                                .validate();
                                          });
                                        }
                                      },
                                      key: _keyForm,
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
                                                "ĐĂNG NHẬP",
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
                                                child: Text("Tên tài khoản"),
                                              ),
                                              MyTextField(
                                                validator: (p0) {
                                                  bool isEmail = RegExp(
                                                          r"^[a-zA-Z0-9]{5,12}$")
                                                      .hasMatch(p0!);
                                                  return isEmail
                                                      ? null
                                                      : "Tài khoản không chứa kí tự đặc biệt, 5-12 kí tự";
                                                },
                                                hintText: "Nhập tài khoản",
                                                icon: const Icon(Icons.person),
                                                label: "Tài khoản",
                                                controller: usernameController,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 4, top: 12),
                                                child: Text("Mật khẩu"),
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
                                                label: "Mật khẩu",
                                                controller: passwordController,
                                                hintText: "Nhập mật khẩu",
                                                icon: IconButton(
                                                    icon: Icon(isShowPass
                                                        ? Icons.visibility_off
                                                        : Icons.visibility),
                                                    onPressed:
                                                        _onChangeShowPass),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  MyCheckBox(
                                                    value: cbxSaveLogin,
                                                    onChanged: (p0) =>
                                                        _onChangeSaveLogin(p0!),
                                                  ),
                                                  const Text(
                                                      'Ghi nhớ đăng nhập')
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SendEmailScreen()),
                                                  );
                                                },
                                                child: const Text(
                                                  'Quên mật khẩu',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
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
                                                onPressed: _btnLogin,
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
      ),
    );
  }
}

class ActionTest extends StatefulWidget {
  const ActionTest({super.key, required this.controllerIpv4});

  final TextEditingController controllerIpv4;

  @override
  State<ActionTest> createState() => _ActionTestState();
}

class _ActionTestState extends State<ActionTest> {
  late FlutterLocalNotificationsPlugin noti;

  @override
  void initState() {
    noti = FlutterLocalNotificationsPlugin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilledButton(
            onPressed: () async {
              if (Platform.isAndroid || Platform.isIOS) {
                await NotificationMobileService.showNoti(1111, noti);
              } else {
                await showNotiWindow();
              }
            },
            child: const Text("notification")),
        FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Nhập IPV4"),
                  content: TextField(
                    onChanged: (value) {
                      setState(() {
                        widget.controllerIpv4.text = value;
                      });
                    },
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 16),
                        hintText: "192.168.1.10"),
                    controller: widget.controllerIpv4,
                  ),
                  actions: [
                    FilledButton(
                        onPressed: () {
                          Env.BASE_URL =
                              "http://${widget.controllerIpv4.text}:8080";
                          Env.SOCKET_URL =
                              "http://${widget.controllerIpv4.text}:8080";
                          print(Env.BASE_URL);
                          Navigator.pop(context);
                        },
                        child: const Text("Đặt"))
                  ],
                ),
              );
            },
            child: const Text('enter ipv4')),
      ],
    );
  }
}

class LeadContentLogin extends StatelessWidget {
  const LeadContentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
        color: colorScheme(context).secondary.withOpacity(0.8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipOval(
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset("assets/images/chicken.png"),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "AZFOOD",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).scrim.withOpacity(0.6)),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              "Là một hệ thống trao đổi tương tác một cách tự nhiên và an toàn. Hệ thống hoạt động theo nguyên tắc tự nguyện trao đổi giữa các thành viên, cùng giúp nhau tăng tương tác, tăng hiệu quả bán hàng, truyền thông#traodoisub , #tangsub, #tuongtaccheo, #tuongtacfb, #tangtheodoimienphi, #tanglikemienphi, #tanglike, #tangtheodoi, #tangcmt, #tangcamxuc, #tangshare, #cayxu, #toolcayxu, #tangview, #tangtiktok, #traodoitiktok, #tiktok #tangcmt, #tangcamxuc, #tangshare, #cayxu, #toolcayxu, #tangview, #tangtiktok, #traodoitiktok, #tiktok #tangcmt, #tangcamxuc, #ta",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          )
        ],
      ),
    );
  }
}
