import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/widgets/my_drawer.dart';

final ZoomDrawerController z = ZoomDrawerController();

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({Key? key}) : super(key: key);

  @override
  _ZoomState createState() => _ZoomState();
}

class _ZoomState extends State<HomeMenuScreen> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    return ZoomDrawer(
        controller: z,
        style: DrawerStyle.style3,
        slideWidth: sizeScreen.width*0.75,
        showShadow: true,
        menuBackgroundColor: colorScheme(context).onPrimary.withOpacity(0.95),
        mainScreen: const HomeScreen(),
        angle: 0,
        menuScreen: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return MyDrawer(
                profile: state.profile ??
                    Profile(
                        id: 0,
                        username: "username",
                        password: "password",
                        name: "name",
                        role: "role",
                        phoneNumber: "phoneNumber",
                        email: "email"));
          },
        ));
  }
}
