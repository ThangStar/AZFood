import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class FormProfile extends StatefulWidget {
  const FormProfile({
    super.key,
    required this.profile,
  });
  final Profile profile;

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  final controllerEmail = TextEditingController(text: "");
  final controllerPhone = TextEditingController(text: "");
  final controllerBirth = TextEditingController();
  String? errorEmail;
  String? errorPhone;

  @override
  void initState() {
    super.initState();
    controllerBirth.text = "2023-10-08 00:00:00.000";
    _fillDataForm();
    _parseSelectedDate();
  }

  void _fillDataForm() {
    if (widget.profile.email != null) {
      controllerEmail.text = widget.profile.email as String;
    }
    if (widget.profile.phoneNumber != null) {
      controllerPhone.text = widget.profile.phoneNumber as String;
    }
  }

  DateTime selectedDate = DateTime.now();
  void _parseSelectedDate() {
    if (controllerBirth.text.isNotEmpty) {
      selectedDate = DateTime.parse(controllerBirth.text);
    }
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPhone.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.light(
            primary: colorScheme(context).primary,
          ),
        ),
        child: child!,
      ),
      initialDatePickerMode: DatePickerMode.year,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
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
        print(selectedDate);
      });
    }
  }

  File? selectedImage;
  bool changeImage = false;
  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "ẢNH ĐẠI DIỆN",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).scrim,
                ),
          ),
          elevation: 24.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          backgroundColor: colorScheme(context).background,
          surfaceTintColor: Colors.transparent,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: colorScheme(context).scrim,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: selectedImage != null
                            ? Image.file(
                                selectedImage!,
                                width: 300,
                                height: 300,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/avatar.jpg',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorScheme(context).primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(3.0), // Độ cong của viền
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.camera,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          const SizedBox(width: 10),
                          Text("Chọn ảnh từ Camera",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 15,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
                        ],
                      ),
                      onPressed: () async {
                        try {
                          final pickedImage =
                              await _pickImage(ImageSource.camera);
                          if (pickedImage == null) return;
                          setState(() {
                            selectedImage = pickedImage;
                          });
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.transparent,
                                title: Center(
                                  child: Icon(
                                    Icons.report_gmailerrorred_outlined,
                                    size: 60,
                                    color: colorScheme(context).error,
                                  ),
                                ),
                                content: Text(
                                    'Mở camera không khả dụng trên trình duyệt web.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontSize: 15)),
                                actions: [
                                  ButtonBar(
                                    alignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    colorScheme(context)
                                                        .primary),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 50.0,
                                                vertical: 5.0),
                                            child: Text('ĐÓNG',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            colorScheme(context)
                                                                .onSecondary)),
                                          )),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                          print(e);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorScheme(context).primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(3.0), // Độ cong của viền
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.image_outlined, color: Colors.white),
                          const SizedBox(width: 10),
                          Text("Chọn ảnh từ Gallery",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 15,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1))),
                        ],
                      ),
                      onPressed: () async {
                        final pickedImage =
                            await _pickImage(ImageSource.gallery);
                        if (pickedImage != null) {
                          setState(() {
                            selectedImage = pickedImage;
                          });
                        }
                      },
                    )
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () => Navigator.pop(context, "cancel"),
            ),
            TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context, "ok");
                  setState(() {
                    changeImage = (selectedImage != null);
                  });
                }),
          ],
        );
      },
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);
    if (image == null) return null;
    return File(image.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment(checkDevice(size.width, 1.5, 1.1, 1.1),
                  checkDevice(size.width, -1.2, -1.0, -1.0)),
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(
                        50.0 * checkDevice(size.width, 1.0, 1.5, 1.6)),
                    child: (() {
                      if (changeImage) {
                        return Image.file(
                          selectedImage!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      } else if (widget.profile.imgUrl != null) {
                        return Image.network('${widget.profile.imgUrl}',
                            fit: BoxFit.cover);
                      } else {
                        return Image.asset('assets/images/avatar.jpg',
                            fit: BoxFit.cover);
                      }
                    })(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: EdgeInsets.all(
                        15.0 * checkDevice(size.width, 1, 1.2, 1.2)),
                    surfaceTintColor: colorScheme(context).onSecondary,
                    backgroundColor: Colors.white,
                    foregroundColor: colorScheme(context).outlineVariant,
                  ),
                  child: const Icon(
                    Icons.create_outlined,
                    color: Color.fromRGBO(102, 103, 106, 1),
                    size: 20.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "${widget.profile.name}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 15.0 * checkDevice(size.width, 1.0, 1.2, 1.3),
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).scrim.withOpacity(0.8)),
            ),
            const SizedBox(height: 15),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(238, 245, 239, 1),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Text(
                widget.profile.role == "admin" ? "Admin" : "User",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15.0,
                    color: const Color.fromRGBO(94, 194, 129, 1)),
              ),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                TextField(
                  controller: controllerEmail,
                  style: TextStyle(
                    color: colorScheme(context).scrim,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).error,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).error,
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 15, color: colorScheme(context).scrim),
                    hintText: 'Nhập địa chỉ email...',
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: errorEmail != null
                          ? colorScheme(context).error
                          : colorScheme(context).outline,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    errorText: errorEmail,
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        errorEmail = "Email không được để trống.";
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                          .hasMatch(value)) {
                        errorEmail =
                            "Email không đúng định dạng, vui lòng nhập lại.";
                      } else {
                        errorEmail = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: colorScheme(context).scrim),
                  controller: controllerPhone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).error,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).error,
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 15, color: colorScheme(context).scrim),
                    hintText: 'Nhập số điện thoại...',
                    labelText: 'Số điện thoại',
                    errorText: errorPhone,
                    labelStyle: TextStyle(
                      color: errorPhone != null
                          ? colorScheme(context).error
                          : colorScheme(context).outline,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        errorPhone = "Số điện thoại không được để trống.";
                      } else if (!RegExp(r'(^0\d{9}$)').hasMatch(value)) {
                        errorPhone =
                            "Số điện thoại không đúng định dạng, vui lòng nhập lại.";
                      } else {
                        errorPhone = null;
                      }
                    });
                  },
                ),
                const SizedBox(height: 15),
                TextField(
                  readOnly: true,
                  enableInteractiveSelection: true,
                  controller: controllerBirth,
                  style: TextStyle(color: colorScheme(context).scrim),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        width: 2,
                        color: colorScheme(context).outlineVariant,
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontSize: 15, color: colorScheme(context).scrim),
                    hintText: 'Chọn ngày sinh...',
                    labelText: 'Ngày sinh',
                    labelStyle: TextStyle(
                      color: colorScheme(context).outline,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20.0),
                    suffixIcon: Theme(
                      data: Theme.of(context).copyWith(
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13.0, vertical: 20.0),
                          minimumSize: Size.zero,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                          ),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: colorScheme(context).onSurfaceVariant,
                        ),
                        onPressed: () => {
                          _selectDate(context),
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 350.0),
                        child: Container(
                          height: 45.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
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
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'LƯU THAY ĐỔI',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      fontSize: 14,
                                      color: colorScheme(context).background),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}