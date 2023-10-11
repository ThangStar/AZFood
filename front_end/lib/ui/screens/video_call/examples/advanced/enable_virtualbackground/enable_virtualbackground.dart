import 'dart:io';
import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../../../../utils/dio.dart';
import '../../../../../blocs/video_call/video_call_bloc.dart';
import '../../../components/example_actions_widget.dart';
import '../../../components/log_sink.dart';
import '../../../components/remote_video_views_widget.dart';
import '../../../components/rgba_image.dart';
import '../enable_spatial_audio/enable_spatial_audio.dart';
import '../spatial_audio_with_media_player/spatial_audio_with_media_player.dart';

class EnableVirtualBackground extends StatefulWidget {
  const EnableVirtualBackground({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EnableVirtualBackgroundState();
}

class _EnableVirtualBackgroundState extends State<EnableVirtualBackground>
    with KeepRemoteVideoViewsMixin {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  late TextEditingController _controller;
  bool _isEnabledVirtualBackgroundImage = false;

  String channelId = config.channelId;
  late final TextEditingController _localUidController;
  late final TextEditingController _screenShareUidController;
  bool _isScreenShared = false;
  late VideoCallBloc videoCallBloc;

  @override
  void initState() {
    super.initState();
    videoCallBloc = BlocProvider.of<VideoCallBloc>(context);
    _controller = TextEditingController(text: config.channelId);
    _screenShareUidController = TextEditingController(text: '1001');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    videoCallBloc.add(ResetUidSelected());
    _engine.release();
  }

  Future<void> _updateScreenShareChannelMediaOptions() async {
    final shareShareUid = int.tryParse(_screenShareUidController.text);
    if (shareShareUid == null) return;
    await _engine.updateChannelMediaOptionsEx(
      options: const ChannelMediaOptions(
        publishScreenTrack: true,
        publishSecondaryScreenTrack: true,
        publishCameraTrack: false,
        publishMicrophoneTrack: false,
        publishScreenCaptureAudio: true,
        publishScreenCaptureVideo: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      connection:
          RtcConnection(channelId: _controller.text, localUid: shareShareUid),
    );
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
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

  Future<void> _enableVirtualBackground(String source) async {
    ByteData data = await rootBundle.load(source);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String p = path.join(appDocDir.path, "${source.split("/").last}");
    final file = File(p);
    if (!(await file.exists())) {
      await file.create();
      await file.writeAsBytes(bytes);
    }

    await _engine.enableVirtualBackground(
        enabled: _isEnabledVirtualBackgroundImage,
        backgroundSource: VirtualBackgroundSource(
            backgroundSourceType: BackgroundSourceType.backgroundImg,
            source: p),
        segproperty:
            const SegmentationProperty(modelType: SegModelType.segModelAi));
  }

  void _joinChannel() async {
    String token = config.token;
    int ran = Random().nextInt(10000);
    try {
      Response res = await http.get(
          "https://cute-singlet-cod.cyclic.app/rtc/a/publisher/userAccount/$ran/");
      token = res.data['rtcToken'];
      print("TOKENSSSSSSSSSS: ${res.data['rtcToken']}");
    } catch (err) {
      print("LỖIs $err");
    }
    await _engine.joinChannel(
        token: token,
        channelId: "a",
        uid: ran,
        options: const ChannelMediaOptions());
    await Future.delayed(2.seconds);
    setState(() {
      loading = false;
    });
  }

  _leaveChannel() async {
    if (_isEnabledVirtualBackgroundImage) {
      await _enableVirtualBackground("");
    }
    await _engine.leaveChannel();
  }

  bool isPitched = false;
  bool muted = false;
  bool loading = true;
  int uidSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Container(
          color: colorScheme(context).background,
          child: Stack(
            children: [
              BlocBuilder<VideoCallBloc, VideoCallState>(
                builder: (context, state) {
                  return state.uidSelected != 0 &&
                          state.counterSelected % 2 == 0
                      ? AgoraVideoView(
                          controller: VideoViewController.remote(
                            rtcEngine: _engine,
                            canvas: VideoCanvas(uid: state.uidSelected),
                            connection: RtcConnection(
                              channelId: channelId,
                            ),
                          ),
                        )
                  // ? Text("COUNTER: ${state.counterSelected}")
                      : state.uidSelected != 0 && state.counterSelected % 2 != 0
                          ? Stack(
                            children: [
                              AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: state.uidSelected),
                                    connection: RtcConnection(
                                      channelId: channelId,
                                    ),
                                  ),
                                ),
                            ],
                          )
                          : loading
                              ? const SizedBox.shrink()
                              : Center(
                                  child: Container(
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: colorScheme(context)
                                          .scrim
                                          .withOpacity(0.6),
                                      border: Border.all(
                                          width: 2,
                                          color: colorScheme(context).tertiary),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: SizedBox.square(
                                        child: Image.asset(
                                      'assets/images/chicken.png',
                                      fit: BoxFit.contain,
                                    )),
                                  ),
                                );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RemoteVideoViewsWidget(
                    key: keepRemoteVideoViewsKey,
                    rtcEngine: _engine,
                    channelId: _controller.text,
                    onSelectedUser: (int uid) {
                      context
                          .read<VideoCallBloc>()
                          .add(OnChangeUidSelected(uidSelected: uid));
                    }),
              ),
              loading
                  ? Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                              child: const Text(
                            "🌎",
                            style: TextStyle(fontSize: 100),
                          )
                                  .animate(
                                    onComplete: (controller) =>
                                        controller.repeat(),
                                  )
                                  .rotate(duration: 1.seconds)),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Đang kết nối cuộc gọi..",
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      ),
                    )
                  : Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: AgoraVideoView(
                            controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        )),
                      ),
                    ),
            ],
          ),
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
                                              onTap: () {
                                                Navigator.pop(context);
                                                if (isJoined) {
                                                  setState(() {
                                                    _isEnabledVirtualBackgroundImage =
                                                        false;
                                                  });
                                                  _enableVirtualBackground(
                                                      "assets/images/bg_app_bar.jpg");
                                                }
                                              },
                                              child: Container(
                                                color: Colors.grey,
                                                child: const Icon(
                                                    Icons.image_not_supported),
                                              )),
                                          GestureDetector(
                                            child: Container(
                                              color: colorScheme(context)
                                                  .background,
                                              child: Image.asset(
                                                "assets/images/bg_app_bar.jpg",
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                setState(() {
                                                  _isEnabledVirtualBackgroundImage =
                                                      true;
                                                });
                                                _enableVirtualBackground(
                                                    "assets/images/bg_app_bar.jpg");
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              color: colorScheme(context)
                                                  .background,
                                              child: Image.asset(
                                                "assets/images/background.jpg",
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                setState(() {
                                                  _isEnabledVirtualBackgroundImage =
                                                      false;
                                                });
                                                _enableVirtualBackground(
                                                    "assets/images/background.jpg");
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              color: colorScheme(context)
                                                  .background,
                                              child: Image.asset(
                                                "assets/images/bg_meet_1.png",
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                setState(() {
                                                  _isEnabledVirtualBackgroundImage =
                                                      true;
                                                });
                                                _enableVirtualBackground(
                                                    "assets/images/bg_meet_1.png");
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              color: colorScheme(context)
                                                  .background,
                                              child: Image.asset(
                                                "assets/images/bg_meet_2.jpg",
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                setState(() {
                                                  _isEnabledVirtualBackgroundImage =
                                                      true;
                                                });
                                                _enableVirtualBackground(
                                                    "assets/images/bg_meet_2.jpg");
                                              }
                                            },
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              color: colorScheme(context)
                                                  .background,
                                              child: Image.asset(
                                                "assets/images/bg_meet_3.jpg",
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.pop(context);
                                              if (isJoined) {
                                                setState(() {
                                                  _isEnabledVirtualBackgroundImage =
                                                      true;
                                                });
                                                _enableVirtualBackground(
                                                    "assets/images/bg_meet_3.jpg");
                                              }
                                            },
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
                      onPressed: () {},
                      // startScreenShare ,
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Scaffold(
                      //         appBar: AppBar(),
                      //         body: ScreenSharing(),
                      //       ),
                      //     ));
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
                      icon: Icon(Icons.volume_up),
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
                      onPressed: () async {
                        //face detection
                        await _engine.enableFaceDetection(true);
                      },
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
            // if (defaultTargetPlatform == TargetPlatform.android ||
            //     defaultTargetPlatform == TargetPlatform.iOS)
            //   ScreenShareMobile(
            //       rtcEngine: _engine,
            //       isScreenShared: _isScreenShared,
            //       onStartScreenShared: () {
            //         if (isJoined) {
            //           _updateScreenShareChannelMediaOptions();
            //         }
            //       },
            //       onStopScreenShare: () {}),
            // if (defaultTargetPlatform == TargetPlatform.windows ||
            //     defaultTargetPlatform == TargetPlatform.macOS)
            //   ScreenShareDesktop(
            //       rtcEngine: _engine,
            //       isScreenShared: _isScreenShared,
            //       onStartScreenShared: () {
            //           _updateScreenShareChannelMediaOptions();
            //       },
            //       onStopScreenShare: () {}),
          ],
        );
      },
    );
  }
}

class ScreenShareMobile extends StatefulWidget {
  const ScreenShareMobile(
      {Key? key,
      required this.rtcEngine,
      required this.isScreenShared,
      required this.onStartScreenShared,
      required this.onStopScreenShare})
      : super(key: key);

  final RtcEngine rtcEngine;
  final bool isScreenShared;
  final VoidCallback onStartScreenShared;
  final VoidCallback onStopScreenShare;

  @override
  State<ScreenShareMobile> createState() => _ScreenShareMobileState();
}

class _ScreenShareMobileState extends State<ScreenShareMobile>
    implements ScreenShareInterface {
  final MethodChannel _iosScreenShareChannel =
      const MethodChannel('example_screensharing_ios');

  @override
  bool get isScreenShared => widget.isScreenShared;

  @override
  void onStartScreenShared() {
    widget.onStartScreenShared();
  }

  @override
  void onStopScreenShare() {
    widget.onStopScreenShare();
  }

  @override
  RtcEngine get rtcEngine => widget.rtcEngine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: !isScreenShared ? startScreenShare : stopScreenShare,
            child: Text('${isScreenShared ? 'Stop' : 'Start'} screen share'),
          ),
        )
      ],
    );
  }

  @override
  void startScreenShare() async {
    if (isScreenShared) return;

    await rtcEngine.startScreenCapture(
        const ScreenCaptureParameters2(captureAudio: true, captureVideo: true));
    await rtcEngine.startPreview(sourceType: VideoSourceType.videoSourceScreen);
    _showRPSystemBroadcastPickerViewIfNeed();
    onStartScreenShared();
  }

  @override
  void stopScreenShare() async {
    if (!isScreenShared) return;

    await rtcEngine.stopScreenCapture();
    onStopScreenShare();
  }

  Future<void> _showRPSystemBroadcastPickerViewIfNeed() async {
    if (defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }

    await _iosScreenShareChannel
        .invokeMethod('showRPSystemBroadcastPickerView');
  }
}

class ScreenShareDesktop extends StatefulWidget {
  const ScreenShareDesktop(
      {Key? key,
      required this.rtcEngine,
      required this.isScreenShared,
      required this.onStartScreenShared,
      required this.onStopScreenShare})
      : super(key: key);

  final RtcEngine rtcEngine;
  final bool isScreenShared;
  final VoidCallback onStartScreenShared;
  final VoidCallback onStopScreenShare;

  @override
  State<ScreenShareDesktop> createState() => _ScreenShareDesktopState();
}

class _ScreenShareDesktopState extends State<ScreenShareDesktop>
    implements ScreenShareInterface {
  List<ScreenCaptureSourceInfo> _screenCaptureSourceInfos = [];
  late ScreenCaptureSourceInfo _selectedScreenCaptureSourceInfo;

  @override
  bool get isScreenShared => widget.isScreenShared;

  @override
  void onStartScreenShared() {
    widget.onStartScreenShared();
  }

  @override
  void onStopScreenShare() {
    widget.onStopScreenShare();
  }

  @override
  RtcEngine get rtcEngine => widget.rtcEngine;

  Future<void> _initScreenCaptureSourceInfos() async {
    SIZE thumbSize = const SIZE(width: 50, height: 50);
    SIZE iconSize = const SIZE(width: 50, height: 50);
    _screenCaptureSourceInfos = await rtcEngine.getScreenCaptureSources(
        thumbSize: thumbSize, iconSize: iconSize, includeScreen: true);
    _selectedScreenCaptureSourceInfo = _screenCaptureSourceInfos[0];
    setState(() {});
  }

  Widget _createDropdownButton() {
    if (_screenCaptureSourceInfos.isEmpty) return Container();
    return DropdownButton<ScreenCaptureSourceInfo>(
        items: _screenCaptureSourceInfos.map((info) {
          Widget image;
          if (info.iconImage!.width! != 0 && info.iconImage!.height! != 0) {
            image = Image(
              image: RgbaImage(
                info.iconImage!.buffer!,
                width: info.iconImage!.width!,
                height: info.iconImage!.height!,
              ),
            );
          } else if (info.thumbImage!.width! != 0 &&
              info.thumbImage!.height! != 0) {
            image = Image(
              image: RgbaImage(
                info.thumbImage!.buffer!,
                width: info.thumbImage!.width!,
                height: info.thumbImage!.height!,
              ),
            );
          } else {
            image = const SizedBox(
              width: 50,
              height: 50,
            );
          }

          return DropdownMenuItem(
            value: info,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                image,
                Text('${info.sourceName}', style: const TextStyle(fontSize: 10))
              ],
            ),
          );
        }).toList(),
        value: _selectedScreenCaptureSourceInfo,
        onChanged: isScreenShared
            ? null
            : (v) {
                setState(() {
                  _selectedScreenCaptureSourceInfo = v!;
                });
              });
  }

  @override
  void initState() {
    super.initState();

    _initScreenCaptureSourceInfos();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _createDropdownButton(),
        if (_screenCaptureSourceInfos.isNotEmpty)
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: startScreenShare,
                  child:
                      Text('${isScreenShared ? 'Stop' : 'Start'} screen share'),
                ),
              )
            ],
          ),
      ],
    );
  }

  @override
  void startScreenShare() async {
    if (isScreenShared) return;

    final sourceId = _selectedScreenCaptureSourceInfo.sourceId;

    if (_selectedScreenCaptureSourceInfo.type ==
        ScreenCaptureSourceType.screencapturesourcetypeScreen) {
      await rtcEngine.startScreenCaptureByDisplayId(
          displayId: sourceId!,
          regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
          captureParams: const ScreenCaptureParameters(
            captureMouseCursor: true,
            frameRate: 30,
          ));
    } else if (_selectedScreenCaptureSourceInfo.type ==
        ScreenCaptureSourceType.screencapturesourcetypeWindow) {
      await rtcEngine.startScreenCaptureByWindowId(
        windowId: sourceId!,
        regionRect: const Rectangle(x: 0, y: 0, width: 0, height: 0),
        captureParams: const ScreenCaptureParameters(
          captureMouseCursor: true,
          frameRate: 30,
        ),
      );
    }

    onStartScreenShared();
  }

  @override
  void stopScreenShare() async {
    if (!isScreenShared) return;

    await rtcEngine.stopScreenCapture();
    onStopScreenShare();
  }
}

abstract class ScreenShareInterface {
  void onStartScreenShared();

  void onStopScreenShare();

  bool get isScreenShared;

  RtcEngine get rtcEngine;

  void startScreenShare();

  void stopScreenShare();
}
