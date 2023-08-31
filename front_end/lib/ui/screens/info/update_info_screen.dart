import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_button_gradient.dart';
import 'package:restaurant_manager_app/ui/widgets/my_outline_button.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
    final _formKey = GlobalKey<FormState>();
    @override
  Scaffold build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
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
            color: colorScheme(context).outline,
            width: 2
          )
        ),
      ),
      body: Container(
        color: colorScheme(context).background,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: const Alignment(1.3, 1.3),
                children: [
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(50), // Image radius
                      child: Image.asset('assets/images/avatar.jpg', fit: BoxFit.cover,),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: colorScheme(context).background,
                      padding: const EdgeInsets.all(8),
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
                            ?.copyWith(fontSize: 12,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "Email address: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
                       ),
                    TextField(
                      decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme(context).onSurfaceVariant,
                        ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   borderSide: BorderSide(color: colorScheme(context).primary),
                      // ),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Nhập địa chỉ email...',
                      contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone Number: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
                       ),
                    TextField(
                      decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_in_talk_outlined,
                        color: colorScheme(context).onSurfaceVariant,
                        ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   borderSide: BorderSide(color: colorScheme(context).primary),
                      // ),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Nhập số điện thoại...',
                      contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Phone Number: ",
                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13),
                       ),
                    TextField(
                      decoration: InputDecoration(
                      suffixIcon: Theme(
                        data: Theme.of(context).copyWith(
                          splashFactory: NoSplash.splashFactory,
                        ),
                        child: TextButton(
                        style: TextButton.styleFrom(
                          // minimumSize: Size.zero,
                          // padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0),
                          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(1)),
                          ),
                        ),
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: colorScheme(context).onSurfaceVariant,
                          ),
                        onPressed: () {},
                        ),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   borderSide: BorderSide(color: colorScheme(context).primary),
                      // ),
                      hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: 12),
                      hintText: 'Ví dụ: 01/01/2001',
                      contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 115,),
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
                          onTap: () {},
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}