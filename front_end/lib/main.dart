import 'dart:io';
import 'dart:isolate';
import 'package:calendar_view/calendar_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:restaurant_manager_app/routers/socket.event.dart';
import 'package:restaurant_manager_app/services/notification_window.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/blocs/calendar/calendar_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/chart/chart_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/forgot_pass/forgot_password_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/initial/initial_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/invoice/invoice_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/message/message_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/order/order_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/product/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/auth/authentication_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/profile/profile_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/table/table_bloc.dart';
import 'package:restaurant_manager_app/ui/blocs/video_call/video_call_bloc.dart';
import 'package:restaurant_manager_app/ui/screens/auth/login_screen.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/advanced/set_beauty_effect/set_beauty_effect.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/video_call_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/theme/text_theme.dart';
import 'package:restaurant_manager_app/utils/io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'constants/env.dart';
import 'model/message.dart';

late List<CameraDescription> cameras;

isolateListen(ReceivePort port) {
  port.listen((msg) {
    MySharePreferences.loadProfile().then((value) {
      Message ms = msg as Message;
      print("Received message from isolate ${msg.message}");
      if (value?.id != ms.sendBy) {
        showNotiWindow(title: msg.profile?.name, body: msg.message);
      }
    });
  });
}

isolateEnqueue(ReceivePort port) {
  Isolate.spawn((message) {
    onNotiMsgFromServer(message);
  }, {'SOCKET_URL': Env.SOCKET_URL, "PORT": port.sendPort});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var port = ReceivePort();
  try {
    if (!kIsWeb) {
      if (Platform.isAndroid || Platform.isIOS) {
        print("object1");
        cameras = await availableCameras();
      } else if (Platform.isWindows) {
        print("object2");
        await localNotifier.setup(
          appName: 'AZFood',
          // The parameter shortcutPolicy only works on Windows
          shortcutPolicy: ShortcutPolicy.requireCreate,
        );
      }
    }
    print("object3");
    runApp(const MyApp());

    //isolate
    isolateListen(port);
    isolateEnqueue(port);
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final bool _showPerformanceOverlay = false;

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
                BlocProvider(
                  create: (context) => InvoiceBloc(),
                ),
                BlocProvider(
                  create: (context) => MessageBloc(),
                ),
                BlocProvider(
                  create: (context) => CalendarBloc(),
                ),
                BlocProvider(
                  create: (context) => ForgotPasswordBloc(),
                ),
                BlocProvider(
                  create: (context) => ForgotPasswordBloc(),
                ),
                BlocProvider(
                  create: (context) => ProfileBloc(),
                ),
                BlocProvider(
                  create: (context) => VideoCallBloc(),
                ),
                BlocProvider(
                  create: (context) => ChartBloc(),
                ),
              ],
              child: CalendarControllerProvider(
                controller: EventController(),
                child: MaterialApp(
                    showPerformanceOverlay: _showPerformanceOverlay,
                    themeMode: currentMode,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        useMaterial3: true,
                        colorScheme: lightColorScheme,
                        textTheme: textTheme(context)),
                    darkTheme: ThemeData(
                        useMaterial3: true, colorScheme: darkColorScheme),
                    home: LoginScreen()),
              ));
        });
  }
}

@pragma('vm:entry-point')
void onNotiMsgFromServer(Map<dynamic, dynamic> params) {
  print("TASK1!!!!!!!!!!!!${params['SOCKET_URL']}");
  IoClient client = IoClient();
  client.updateUrl(url: params['SOCKET_URL']);
  IO.Socket io = client.io;
  if (!io.hasListeners(SocketEvent.onNotiMsgGroup)) {
    io.on(SocketEvent.onNotiMsgGroup, (data) {
      //transform data
      print("HAVING A NEW MESSAGE!!!!! $data");
      Message msg = Message.fromMap(data);
      params['PORT'].send(msg);
    });
  }
}
