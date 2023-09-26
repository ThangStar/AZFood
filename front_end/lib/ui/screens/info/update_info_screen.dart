import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {

  DateTime selectedDate = DateTime.now();
  //Validate Form
  final _controllerEmail = TextEditingController();
  final _controllerPhone = TextEditingController();
  bool _submitted = false;
  String? get _errorTextEmail {
    final text = _controllerEmail.value.text;
    if (text.isEmpty) {
      return 'Email không được để trống.';
    }
    if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(text)) {
      return 'Email không đúng định dạng, vui lòng nhập lại.';
    }
    return null;
  }
  String? get _errorTextPhone {
    final text = _controllerPhone.value.text;
    if (text.isEmpty) {
      return 'Số điện thoại không được để trống.';
    }
    if (!RegExp(r'(^0\d{9}$)').hasMatch(text)) {
      return 'Số điện thoại không đúng định dạng, vui lòng nhập lại.';
    }
    return null;
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
      initialDatePickerMode:DatePickerMode.year,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      locale: const Locale('en', 'US'),
      helpText: 'CHỌN NGÀY SINH NHẬT',
      cancelText: 'THOÁT',
      confirmText: 'THAY ĐỔI',
      errorFormatText: 'Không đúng định dạng.',
      errorInvalidText: 'Số ngày, tháng, năm bạn nhập không tồn tại.',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

    @override
  Scaffold build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme(context).scrim,
          ),
        ),
        title: Text(
          'Cập nhật thông tin',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
        ),
        shape: Border(
          bottom: BorderSide(
            color: colorScheme(context).outlineVariant,
            width: 1,
          )
        ),
      ),
      body: Container(
        color: colorScheme(context).onSecondary,

        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Stack(
                    alignment: const Alignment(1.1, 1.1),
                    children: [
                      ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50), // Image radius
                          child: Image.asset('assets/images/avatar.jpg', fit: BoxFit.cover),
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colorScheme(context).background,
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 15),
                          minimumSize: Size.zero,
                          side: BorderSide(width: 1.0, color: colorScheme(context).onSurfaceVariant),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        child: Icon(
                          Icons.create_outlined,
                          color: colorScheme(context).scrim,
                        ),
                        onPressed: ( ) { },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Đặng Đình Thiên Như Ý",
                    style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 15,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "Email address: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
                       ),
                    TextField(
                      controller: _controllerEmail,
                      decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme(context).onSurfaceVariant,
                        ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Nhập địa chỉ email...',
                      errorText: _submitted ? _errorTextEmail : null,
                      contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone Number: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
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
                        color: colorScheme(context).onSurfaceVariant,
                        ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Nhập số điện thoại...',
                      errorText: _submitted ? _errorTextPhone : null,
                      contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Birthday: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
                       ),
                    TextField(
                      readOnly: true,
                      enableInteractiveSelection: true,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      decoration: InputDecoration(
                        suffixIcon: Theme(
                          data: Theme.of(context).copyWith(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(1)),
                            ),
                          ),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: colorScheme(context).onSurfaceVariant,
                            ),
                          onPressed: () => _selectDate(context),
                          ),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15),
                        hintText: "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year.toString()}",
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyOutlineButton(
                    text: 'Quay lại',
                    onTap: () {},
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyButtonGradient(
                      text: "Cập nhật",
                      onTap: () {
                            
                        setState(() => _submitted = true);
                        if (_errorTextEmail == null && _errorTextPhone == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('VALIDATE OK MAN')),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}