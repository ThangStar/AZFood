import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({
    super.key,
    this.constraints,
    required this.name,
    required this.phoneNumer,
    required this.email,
  });
  final String name;
  final String phoneNumer;
  final String email;
  final BoxConstraints? constraints;
  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  DateTime selectedDate = DateTime.now();
  File? selectedImage;
  //Validate Form
  final _controllerEmail = TextEditingController(text: "");
  final _controllerPhone = TextEditingController(text: "");
  bool _submitted = false;
  String? get _errorTextEmail {
    final text = _controllerEmail.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Email không được để trống.';
      }
      if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(text)) {
        return 'Email không đúng định dạng, vui lòng nhập lại.';
      }
    }
    return null;
  }

  String? get _errorTextPhone {
    final text = _controllerPhone.value.text;
    if (_submitted) {
      if (text.isEmpty) {
        return 'Số điện thoại không được để trống.';
      }
      if (!RegExp(r'(^0\d{9}$)').hasMatch(text)) {
        return 'Số điện thoại không đúng định dạng, vui lòng nhập lại.';
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _controllerEmail.text = widget.email;
    _controllerPhone.text = widget.phoneNumer;
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPhone.dispose();
    super.dispose();
  }

  // ignore: unused_element
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.light(
            primary: colorScheme(context).secondary,
            onPrimary: colorScheme(context).inversePrimary,
            onSurface: colorScheme(context).scrim,
          ),
          dialogBackgroundColor: colorScheme(context).onInverseSurface,
        ),
        child: child!,
      ),
      initialDatePickerMode: DatePickerMode.year,
      initialDate: selectedDate,
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
      locale: const Locale('en', 'US'),
      helpText: 'CHỌN NGÀY SINH',
      cancelText: 'THOÁT',
      confirmText: 'THAY ĐỔI',
      errorFormatText: 'Vui lòng nhập đúng định dạng.',
      errorInvalidText: 'Số ngày, tháng, năm bạn nhập không tồn tại.',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future _pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    setState(() {
      if (image == null) return;
      selectedImage = File(image.path);
      
    });
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("ẢNH ĐẠI DIỆN",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).scrim)),
              content: Container(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    if (selectedImage != null)
                      Image.file(
                        selectedImage!,
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    else
                      Image.asset(
                        'assets/images/avatar.jpg',
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 20),
                    TextButton(
                      child: const Text("Chọn ảnh từ Camera"),
                      onPressed: () {
                        setState(() {
                          _pickImage(ImageSource.camera);
                        });
                      },
                    ),
                    TextButton(
                      child: const Text("Chọn ảnh từ Gallery"),
                      onPressed: () => {
                        setState(() {
                          _pickImage(ImageSource.gallery);
                          // print(selectedImage);
                        })
                      },
                    )
                  ],
                ),
              ),
              elevation: 24.0,
              backgroundColor: colorScheme(context).onTertiary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
              actions: [
                TextButton(
                    child: const Text("CANCEL"),
                    onPressed: () => Navigator.pop(context, "cancel")),
                TextButton(
                    child: const Text("OK"),
                    onPressed: () => Navigator.pop(context, "ok")),
              ],
            );
          });
        });
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
            'Cập nhật thông tin',
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
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment(
                                      checkDevice(size.width, 1.2, 1.0, 1.0),
                                      checkDevice(size.width, 1.2, 1.0, 1.0)),
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(50.0 *
                                            checkDevice(size.width, 1.0, 1.5,
                                                1.6)), // Image radius
                                        child:
                                            //  _showDialog(context) == "ok"
                                            //     ? Image.file(
                                            //         selectedImage!,
                                            //         width: 250,
                                            //         height: 250,
                                            //         fit: BoxFit.cover,
                                            //       )
                                            //     :
                                            Image.asset(
                                                'assets/images/avatar.jpg',
                                                fit: BoxFit.cover),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showDialog();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        side: BorderSide(
                                            width: 1.0,
                                            color: colorScheme(context)
                                                .onSurfaceVariant),
                                        padding: EdgeInsets.all(15.0 *
                                            checkDevice(
                                                size.width, 1, 1.2, 1.3)),
                                        backgroundColor: colorScheme(context)
                                            .onSecondary, // <-- Button color
                                        foregroundColor: colorScheme(context)
                                            .outlineVariant, // <-- Splash color
                                      ),
                                      child: Icon(
                                        Icons.create_outlined,
                                        color: colorScheme(context).scrim,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontSize: 15.0 *
                                              checkDevice(
                                                  size.width, 1.0, 1.2, 1.3),
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
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
                                      "Email address: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 13,
                                              color: _errorTextEmail != null
                                                  ? colorScheme(context).error
                                                  : colorScheme(context).scrim),
                                    ),
                                    TextField(
                                      controller: _controllerEmail,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: _errorTextEmail != null
                                              ? colorScheme(context).error
                                              : colorScheme(context)
                                                  .onSurfaceVariant,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 12),
                                        hintText: 'Nhập địa chỉ email...',
                                        errorText: _errorTextEmail,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Phone Number: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              fontSize: 13,
                                              color: _errorTextPhone != null
                                                  ? colorScheme(context).error
                                                  : colorScheme(context).scrim),
                                    ),
                                    TextField(
                                      controller: _controllerPhone,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.phone_in_talk_outlined,
                                          color: _errorTextPhone != null
                                              ? colorScheme(context).error
                                              : colorScheme(context)
                                                  .onSurfaceVariant,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 12),
                                        hintText: 'Nhập số điện thoại...',
                                        errorText: _errorTextPhone,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "Birthday: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(fontSize: 13),
                                    ),
                                    TextField(
                                      readOnly: true,
                                      enableInteractiveSelection: true,
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                      decoration: InputDecoration(
                                        suffixIcon: Theme(
                                          data: Theme.of(context).copyWith(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                          ),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(1)),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.calendar_month_outlined,
                                              color: colorScheme(context)
                                                  .onSurfaceVariant,
                                            ),
                                            onPressed: () =>
                                                _selectDate(context),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(fontSize: 15),
                                        hintText:
                                            "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString()}",
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
                              height: 50,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 800),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: MyOutlineButton(
                                      text: 'Quay lại',
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: MyButtonGradient(
                                      text: "Cập nhật",
                                      onTap: () {
                                        setState(() => _submitted = true);
                                        if (_errorTextEmail == null &&
                                            _errorTextPhone == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('VALIDATE OK MAN')),
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
