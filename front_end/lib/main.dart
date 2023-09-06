import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_manager_app/courses/ui/drag_drop.dart';
import 'package:restaurant_manager_app/courses/face_detector.dart';
import 'package:restaurant_manager_app/courses/ui/zoom_drawer.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/initial/initial_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/table/table_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/theme/text_theme.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  try {
    if (Platform.isAndroid || Platform.isIOS) {
      cameras = await availableCameras().whenComplete(() {
        print("done! setup face detector");
      });
    }
  } on CameraException catch (e) {
    print(e.code);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MySharePreferences.getIsDarkTheme().then((value) {
      MyApp.themeNotifier.value =
          value ?? false ? ThemeMode.dark : ThemeMode.light;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: MyApp.themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => OrderBloc(),
                ),
                BlocProvider(
                  create: (context) => TableBloc(),
                ),
                BlocProvider(
                  create: (context) => InitialBloc(),
                ),
                BlocProvider(
                  create: (context) => ProductBloc(),
                ),
                BlocProvider(
                  create: (context) => AuthenticationBloc(),
                ),
              ],
              child: MaterialApp(
                themeMode: currentMode,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: lightColorScheme,
                    textTheme: textTheme(context)),
                // darkTheme:
                //     ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
                home: const Zoom(),
              ));
        });
  }
}
