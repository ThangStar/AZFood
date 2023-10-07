import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/config/agora.config.dart'
    as config;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/advanced/process_audio_raw_data/process_audio_raw_data.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/advanced/screen_sharing/screen_sharing.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/examples/advanced/voice_changer/voice_changer.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import '../../../components/example_actions_widget.dart';
import '../../../components/log_sink.dart';
import '../../../components/remote_video_views_widget.dart';
import '../enable_spatial_audio/enable_spatial_audio.dart';
import '../spatial_audio_with_media_player/spatial_audio_with_media_player.dart';

/// EnableVirtualBackground Example
class EnableVirtualBackground extends StatefulWidget {
  /// @nodoc
  const EnableVirtualBackground({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<EnableVirtualBackground>
    with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  late TextEditingController _controller;
  bool _isEnabledVirtualBackgroundImage = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
    _joinChannel();
  }

  Future<void> _enableVirtualBackground() async {
    ByteData data = await rootBundle.load("assets/images/bg_app_bar.jpg");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, 'bg_app_bar.jpg');
    final file = File(p);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(bytes);
    }

    await _engine.enableVirtualBackground(
        enabled: !_isEnabledVirtualBackgroundImage,
        backgroundSource: VirtualBackgroundSource(
            backgroundSourceType: BackgroundSourceType.backgroundImg,
            source: p),
        segproperty:
            const SegmentationProperty(modelType: SegModelType.segModelAi));
    setState(() {
      _isEnabledVirtualBackgroundImage = !_isEnabledVirtualBackgroundImage;
    });
  }

  void _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: _controller.text,
        uid: config.uid,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    if (_isEnabledVirtualBackgroundImage) {
      await _enableVirtualBackground();
    }
    await _engine.leaveChannel();
  }

  bool isPitched = false;
  bool muted = false;

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
                controller: VideoViewController(
              rtcEngine: _engine,
              canvas: const VideoCanvas(uid: 0),
            )),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _controller.text,
              ),
            ),
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            RichText(
                text: TextSpan(
                    text: "Nhóm: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: colorScheme(context).scrim.withOpacity(0.7)),
                    children: [
                  TextSpan(
                      text: "AZFood",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ])),
            SizedBox(
              height: 24,
            ),
            Text(
              "Người tham gia",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme(context).tertiary)),
              height: 300,
              child: ListView.separated(
                itemCount: 12,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  title: Text("${index + 1}. Nông Văn Thắng"),
                  subtitle: Text("Nhân viên"),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                // TextField(
                //   controller: _controller,
                //   decoration: const InputDecoration(hintText: 'Channel ID'),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        color: Colors.white,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                _isEnabledVirtualBackgroundImage
                                    ? Colors.purple
                                    : Colors.grey)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    child: SizedBox(
                                      width: 100,
                                      child: GridView(
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2),
                                        children: [
                                          GestureDetector(
                                            child: Image.asset(
                                              "assets/images/bg_app_bar.jpg",
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                _enableVirtualBackground();
                                              }
                                            },
                                          ),
                                          Image.asset(
                                            "assets/images/background.jpg",
                                          ),
                                          Image.asset(
                                            "assets/images/chicken.png",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        icon: Icon(Icons.broken_image_rounded)),
                    IconButton(
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: ScreenSharing(),
                              ),
                            ));
                      },
                      icon: Icon(Icons.screen_share),
                    ),
                    IconButton(
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              muted ? Colors.red : Colors.grey)),
                      onPressed: () async {
                        setState(() {
                          muted = !muted;
                        });
                        await _engine.muteLocalAudioStream(muted);
                      },
                      icon: Icon( Icons.volume_up),
                    ),

                    IconButton(
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              isPitched ? Colors.blue : Colors.grey)),
                      onPressed: () async {
                        setState(() {
                          isPitched = !isPitched;
                        });
                        isPitched
                            ? await _engine.setLocalVoicePitch(2)
                            : await _engine.setLocalVoicePitch(1);
                      },
                      icon: Icon(Icons.record_voice_over_outlined),
                    ),
                    IconButton(
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                    ),
                    IconButton(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        color: Colors.white,
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        // onPressed: isJoined ? _leaveChannel : _joinChannel,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.call_end)),
                    // Expanded(
                    //   flex: 1,
                    //   child: ElevatedButton(
                    //     onPressed: isJoined ? _leaveChannel : _joinChannel,
                    //     child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
