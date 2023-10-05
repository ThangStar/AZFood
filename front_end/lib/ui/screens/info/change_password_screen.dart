import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_manager_app/ui/blocs/profile/profile_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
    this.constraints,
  });
  final BoxConstraints? constraints;
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  DateTime selectedDate = DateTime.now();
  //Validate Form
  final _controllerOldPassword = TextEditingController(text: "");
  final _controllerNewPassword = TextEditingController(text: "");
  final _controllerRepeatNewPassword = TextEditingController(text: "");

  bool _submitted = false;
  bool passwordVisibleOld = false;
  bool passwordVisibleNew = false;
  bool passwordVisibleRepeat = false;
  bool oldPasswordExist = false;
  String? get _errorTextOldPassword {
    final text = _controllerOldPassword.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Mật khẩu cũ không được để trống.';
      }
      if(oldPasswordExist) {
        return 'Mật khẩu cũ không đúng.';
      }
    }
    return null;
  }

  String? get _errorTextNewPassword {
    final text = _controllerNewPassword.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Mật khẩu mới không được để trống.';
      }
    }
    return null;
  }

  String? get _errorTextRepeatNewPassword {
    final text = _controllerRepeatNewPassword.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Nhập lại mật khẩu không được để trống.';
      }
      if (_controllerNewPassword.value.text.isEmpty) {
        if (text != _controllerNewPassword.value.text) {
          return 'Mật khẩu bạn nhập không trùng với mật khẩu mới.';
        }
        return 'Bạn chưa nhập mật khẩu mới.';
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    passwordVisibleOld = true;
    passwordVisibleNew = true;
    passwordVisibleRepeat = true;
  }

  @override
  void dispose() {
    _controllerOldPassword.dispose();
    _controllerNewPassword.dispose();
    _controllerRepeatNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          myAlert(context, checkDeviceType(size.width), AlertType.success,
                  "Thông báo", "Đổi mật khẩu thành công.")
              .show(context);
          _controllerOldPassword.clear();
          _controllerNewPassword.clear();
          _controllerRepeatNewPassword.clear();
        } else if (state is ChangePasswordFailed) {
          setState(() {
            oldPasswordExist = true;
          });
        } else if (state is ChangePasswordConnectionFailed) {
          myAlert(context, checkDeviceType(size.width), AlertType.error,
                  "Thông báo", "Mất kết nối với máy chủ.")
              .show(context);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme(context).onSecondary,
        appBar: AppBar(
          backgroundColor: colorScheme(context).onTertiary,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleSpacing: -5.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colorScheme(context).scrim,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'THAY ĐỔI MẬT KHẨU',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          shape: Border(
              bottom: BorderSide(
            color: colorScheme(context).outlineVariant,
            width: 1,
          )),
        ),
        body: Center(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        'assets/images/image_password.png',
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        width: 270,
                        child: Text(
                            "Vui lòng tạo mật khẩu mới độ dài từ 10 ~ 25 bao gồm ký tự và số.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 12)),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mật khẩu cũ: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 13,
                                        color: _errorTextOldPassword != null
                                            ? colorScheme(context).error
                                            : colorScheme(context).outline),
                              ),
                              TextField(
                                controller: _controllerOldPassword,
                                obscureText: passwordVisibleOld,
                                obscuringCharacter: '●',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 12),
                                  hintText: 'Nhập mật khẩu cũ...',
                                  errorText: _errorTextOldPassword,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisibleOld
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: colorScheme(context).outline,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisibleOld =
                                              !passwordVisibleOld;
                                        },
                                      );
                                    },
                                  ),
                                  alignLabelWithHint: false,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Mật khẩu mới: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 13,
                                        color: _errorTextNewPassword != null
                                            ? colorScheme(context).error
                                            : colorScheme(context).outline),
                              ),
                              TextField(
                                controller: _controllerNewPassword,
                                obscureText: passwordVisibleNew,
                                obscuringCharacter: '●',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 12),
                                  hintText: 'Nhập mật khẩu mới...',
                                  errorText: _errorTextNewPassword,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisibleNew
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: colorScheme(context).outline,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisibleNew =
                                              !passwordVisibleNew;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Nhập lại mật khẩu mới: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        fontSize: 13,
                                        color:
                                            _errorTextRepeatNewPassword != null
                                                ? colorScheme(context).error
                                                : colorScheme(context).outline),
                              ),
                              TextField(
                                controller: _controllerRepeatNewPassword,
                                obscureText: passwordVisibleRepeat,
                                obscuringCharacter: '●',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontSize: 12),
                                  hintText: "Nhập lại mật khẩu mới...",
                                  errorText: _errorTextRepeatNewPassword,
                                  contentPadding: const EdgeInsets.all(10),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisibleRepeat
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: colorScheme(context).outline,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          passwordVisibleRepeat =
                                              !passwordVisibleRepeat;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                              height: 45.0,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(109, 92, 255, 1),
                                    Color.fromRGBO(160, 91, 255, 1)
                                  ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(255, 0, 0, 0)
                                          .withOpacity(0.2),
                                      spreadRadius: 4,
                                      blurRadius: 12,
                                      offset: const Offset(0, 5),
                                    )
                                  ]),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() => _submitted = true);
                                  if(oldPasswordExist){
                                    oldPasswordExist = false;
                                  }
                                  if (_errorTextOldPassword == null &&
                                      _errorTextNewPassword == null &&
                                      _errorTextRepeatNewPassword == null) {
                                    profileBloc.add(ChangePasswordEvent(
                                        oldPassword:
                                            _controllerOldPassword.text,
                                        newPassword:
                                            _controllerNewPassword.text));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: Text(
                                  'THAY ĐỔI MẬT KHẨU',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontSize: 16,
                                          color:
                                              colorScheme(context).onSecondary),
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
