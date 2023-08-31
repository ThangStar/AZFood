import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  bool light = false;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

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
          'Cá nhân',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(13.0),
              //Bo viền container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorScheme(context).primary,
              ),
              child: Row(
                children:[
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(35), // Image radius
                      child: Image.asset('assets/images/avatar.jpg', fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đặng Đình Thiên Như Ý",
                        style: Theme.of(context)
                        .textTheme.
                        bodyLarge
                        ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: colorScheme(context).onPrimary),
                      ),
                      Text(
                        "Nhân viên chăm chỉ",
                        style: 
                        Theme.of(context).
                        textTheme.
                        bodyLarge
                        ?.copyWith(fontSize: 11,color: colorScheme(context).onPrimary),
                      ),
                    ],
                  ),
                ]
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Thông tin cá nhân",
              style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 14,fontWeight: FontWeight.bold, color: colorScheme(context).primary),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12.0),
              //Bo viền container
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorScheme(context).surfaceVariant,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Giới tính: ", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                      Text("Nam", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày sinh: ", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                      Text("01/01/2001", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Số điện thoại: ", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                      Text("0*********", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email: ", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                      Text("dangdinhthienhuy@gmail.com", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày vào làm: ", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                      Text("01/01/2021", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Dịch vụ tiện ích",
              style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontSize: 14,fontWeight: FontWeight.bold, color: colorScheme(context).primary),
            ),
            const SizedBox(height: 5),
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme(context).outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.manage_accounts_outlined,
                              color: colorScheme(context).outline,
                            ),
                            const SizedBox(width: 10),
                            Text("Cập nhật thông tin cá nhân", style:Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: colorScheme(context).outline,
                        ),
                      ],
                    ),
                    onPressed: ( ) { },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme(context).outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              color: colorScheme(context).outline,
                            ),
                            const SizedBox(width: 10),
                            Text("Đổi mật khẩu", style:Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: colorScheme(context).outline,
                        ),
                      ],
                    ),
                    onPressed: ( ) { },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme(context).outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8.0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.zero),
                      ),
                    ),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.battery_charging_full_outlined,
                              color: colorScheme(context).outline,
                            ),
                            const SizedBox(width: 10),
                            Text("Tiếp kiệm pin", style:Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: colorScheme(context).outline,
                        ),
                      ],
                    ),
                    onPressed: ( ) { },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme(context).outline,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shield_moon_outlined,
                              color: colorScheme(context).outline,
                            ),
                            const SizedBox(width: 10),
                            Text("Chế độ tối", style:Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 35,
                          child: FittedBox(
                          fit: BoxFit.fill,
                            child: Switch(
                              thumbIcon: thumbIcon,
                              activeColor: colorScheme(context).secondary,
                              value: light,
                              onChanged: (bool value) {
                                setState(() {
                                  light = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(horizontal: 3.0,vertical: 8.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.login_outlined,
                        color: colorScheme(context).outline,
                      ),
                      const SizedBox(width: 10),
                      Text("Đăng xuất", style:Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  onPressed: ( ) { },
                ),
              ],
            ),
          ],
        ),
      ),
    );  
  }
}