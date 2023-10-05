import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
  bool passwordVisible = false;
  String? get _errorTextOldPassword {
    final text = _controllerOldPassword.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Mật khẩu cũ không được để trống.';
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
    // _controllerEmail.text = widget.email;
    // _controllerPhone.text = widget.phoneNumer;
    passwordVisible = true;
  }

  @override
  void dispose() {
    _controllerOldPassword.dispose();
    _controllerNewPassword.dispose();
    _controllerRepeatNewPassword.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme(context).onSecondary,
        appBar: AppBar(
          backgroundColor: colorScheme(context).onTertiary,
          scrolledUnderElevation: 0,
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
            'Thay đổi mật khẩu',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          shape: Border(
              bottom: BorderSide(
            color: colorScheme(context).outlineVariant,
            width: 1,
          )),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                            const SizedBox(
                              height: 50,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Mật khẩu cũ: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 13,
                                              color: _errorTextOldPassword !=
                                                      null
                                                  ? colorScheme(context).error
                                                  : colorScheme(context).scrim),
                                    ),
                                    TextField(
                                      controller: _controllerOldPassword,
                                      obscureText: passwordVisible,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 12),
                                        hintText: 'Nhập mật khẩu cũ...',
                                        errorText: _errorTextOldPassword,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(
                                              () {
                                                passwordVisible =
                                                    !passwordVisible;
                                              },
                                            );
                                          },
                                        ),
                                        alignLabelWithHint: false,
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                              color: _errorTextNewPassword !=
                                                      null
                                                  ? colorScheme(context).error
                                                  : colorScheme(context).scrim),
                                    ),
                                    TextField(
                                      controller: _controllerNewPassword,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 12),
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide:
                                                BorderSide(color: Colors.blue)),
                                        hintText: 'Nhập mật khẩu mới...',
                                        errorText: _errorTextNewPassword,
                                        contentPadding:
                                            const EdgeInsets.all(10),
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
                                                  _errorTextRepeatNewPassword !=
                                                          null
                                                      ? colorScheme(context)
                                                          .error
                                                      : colorScheme(context)
                                                          .scrim),
                                    ),
                                    TextField(
                                      controller: _controllerRepeatNewPassword,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 12),
                                        hintText: "Nhập lại mật khẩu mới...",
                                        errorText: _errorTextRepeatNewPassword,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: MyButtonGradient(
                                      text: "THAY ĐỔI MẬT KHẨU",
                                      onTap: () {
                                        setState(() => _submitted = true);
                                        if (_errorTextOldPassword == null &&
                                            _errorTextNewPassword == null &&
                                            _errorTextRepeatNewPassword ==
                                                null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'VALIDATE OK MAN ${_controllerOldPassword.text} / ${_controllerOldPassword.text} / ${_controllerRepeatNewPassword.text}')),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ))));
        }));
  }
}
