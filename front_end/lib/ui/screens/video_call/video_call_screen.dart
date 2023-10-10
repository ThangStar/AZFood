import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/advanced/index.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/basic/index.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'components/android_foreground_service_widget.dart';
import 'components/log_sink.dart';
import 'config/agora.config.dart' as config;
import 'examples/advanced/enable_virtualbackground/enable_virtualbackground.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final _data = [...basic, ...advanced];

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissionIfNeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.call,
              color: Colors.green,
              size: 24,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              ' Video call',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).scrim.withOpacity(0.7)),
            ),
          ],
        ),
        actions: [],
      ),
      body: EnableVirtualBackground(),
    );
  }
}

class VideoCallSetup extends StatefulWidget {
  const VideoCallSetup({super.key});

  @override
  State<VideoCallSetup> createState() => _VideoCallSetupState();
}

class _VideoCallSetupState extends State<VideoCallSetup> {
  final _data = [...basic, ...advanced];

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissionIfNeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APIExample'),
        actions: [],
      ),
      body: _isConfigInvalid()
          ? const InvalidConfigWidget()
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return _data[index]['widget'] == null
                    ? Ink(
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(_data[index]['name'] as String,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white)),
                        ),
                      )
                    : ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            Widget widget = Scaffold(
                              appBar: AppBar(
                                title: Text(_data[index]['name'] as String),
                                // ignore: prefer_const_literals_to_create_immutables
                                actions: [const LogActionWidget()],
                              ),
                              body: _data[index]['widget'] as Widget?,
                            );

                            if (!kIsWeb && Platform.isAndroid) {
                              widget =
                                  AndroidForegroundServiceWidget(child: widget);
                            }

                            return widget;
                          }));
                        },
                        title: Text(
                          _data[index]['name'] as String,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.black),
                        ),
                      );
              },
            ),
    );
  }
}

class InvalidConfigWidget extends StatelessWidget {
  /// Construct the [InvalidConfigWidget]
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text(
          'Make sure you set the correct appId, token, channelId, etc.. in the lib/config/agora.config.dart file.'),
    );
  }
}
