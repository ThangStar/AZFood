import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/info/change_password_screen.dart';
import 'package:restaurant_manager_app/ui/screens/info/update_info_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
    this.constraints,
  });
  final BoxConstraints? constraints;
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Scaffold build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme(context).onSecondary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onTertiary,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: checkDevice(size.width, true, false, false),
        title: Text(
          'Cá nhân',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        shape: Border(
            bottom: BorderSide(
                color: colorScheme(context).outlineVariant, width: 1)),
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  Profile profile = state.profile ??
                      Profile(
                          id: 0,
                          username: "nhuy123",
                          password: "123456",
                          name: "Đặng Đình Thiên Như Ý",
                          role: "admin",
                          phoneNumber: "9876543210",
                          email: "email");
                  return Column(children: <Widget>[
                    InformationView(profile: profile, size: size),
                    const SizedBox(height: 20),
                    UtilitiesView(profile: profile),
                  ]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InformationView extends StatelessWidget {
  const InformationView({
    super.key,
    required this.profile,
    required this.size,
  });

  final Profile profile;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme(context).primary,
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(
                      50.0 * checkDevice(size.width, 1, 1.5, 1.6)),
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${profile.name}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onPrimary),
                  ),
                  Text(
                    profile.role == "admin" ? "Chủ cửa hàng" : "Nhân viên",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 13, color: colorScheme(context).onPrimary),
                  ),
                ],
              ),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thông tin cá nhân",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).primary),
            ),
            const SizedBox(height: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800, maxHeight: 175),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
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
                        Text(
                          "Giới tính: ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "Nam",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ngày sinh: ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "01/01/2001",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Số điện thoại: ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "${profile.phoneNumber}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email: ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "${profile.email}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ngày vào làm: ",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "01/01/2021",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class UtilitiesView extends StatelessWidget {
  const UtilitiesView({
    super.key,
    required this.profile,
  });
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dịch vụ tiện ích",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colorScheme(context).primary),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
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
                            Text(
                              "Cập nhật thông tin cá nhân",
                              style: Theme.of(context)
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateInfoScreen(
                                name: "${profile.name}",
                                phoneNumer: "${profile.phoneNumber}",
                                email: "${profile.email}")),
                      );
                    }),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
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
                          Text(
                            "Đổi mật khẩu",
                            style: Theme.of(context)
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen()),
                    );
                  },
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
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
                          Text(
                            "Tiếp kiệm pin",
                            style: Theme.of(context)
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
