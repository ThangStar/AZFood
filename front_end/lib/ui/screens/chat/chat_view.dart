import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/message.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/screens/video_call/video_call_screen.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/media_picker.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/utils/get_pos_by_key.dart';

import '../../../routers/socket.event.dart';
import '../../../utils/io_client.dart';
import '../../blocs/message/message_bloc.dart';

class ChatViewScreen extends StatefulWidget {
  const ChatViewScreen({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<ChatViewScreen> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {
  late MessageBloc msgBloc;
  ScrollController controllerMsg = ScrollController();
  LoginResponse profile = LoginResponse(
      connexion: false, jwtToken: "jwtToken", id: 0, username: "username");

  @override
  void dispose() {
    controllerMsg.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initProfile();
    _initMessage();
    _listenEvent();
    super.initState();
  }

  _initProfile() {
    MySharePreferences.loadProfile().then((value) {
      setState(() {
        profile = value ??
            LoginResponse(
                connexion: false, jwtToken: "", id: 0, username: "username");
      });
    });
  }

  _initMessage() {
    msgBloc = BlocProvider.of<MessageBloc>(context);
    io.emit(SocketEvent.initialMessage, {"id": '123'});
    if (!io.hasListeners(SocketEvent.onInitialMessage)) {
      io.on(SocketEvent.onInitialMessage, (data) {
        //transform data
        final rs = data as List<dynamic>;
        List<Message> msgs = rs.map((e) {
          return Message.fromMap(e);
        }).toList();
        msgBloc.add(InitMessageEvent(msgs: msgs));
      });
    }
  }

  _listenEvent() {
    if (!io.hasListeners(SocketEvent.onMsgGroup)) {
      io.on(SocketEvent.onMsgGroup, (data) {
        print("data from sever: $data");
      });
    }

    if (!io.hasListeners(SocketEvent.onMsgTypingGroup)) {
      io.on(SocketEvent.onMsgTypingGroup, (data) {
        if (data['id'] != profile.id) {
          msgBloc.add(TypingMessageEvent(data: data));
          _scrollToEnd(true);
        }
      });
    }

    if (!io.hasListeners(SocketEvent.onMsgTypedGroup)) {
      io.on(SocketEvent.onMsgTypedGroup, (data) {
        print(data);
        if (data != profile.id) {
          _scrollToEnd(true);
          msgBloc.add(TypedMessageEvent(id: data));
        }
      });
    }
  }

  _scrollToEnd(bool animate, {bool isLoadFirst = false}) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(controllerMsg.position.maxScrollExtent);
      if (controllerMsg.hasClients) {
        animate
            ? controllerMsg.animateTo(
                controllerMsg.position.maxScrollExtent + 580,
                duration: 500.ms,
                curve: Curves.fastOutSlowIn)
            : controllerMsg.jumpTo(controllerMsg.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme(context).surfaceVariant,
      appBar: AppBar(
        shadowColor: colorScheme(context).tertiary,
        surfaceTintColor: colorScheme(context).onPrimary,
        elevation: 3,
        leadingWidth: size.width > mobileWidth ? null : 90,
        leading: Row(
          children: [
            if (!(size.width > mobileWidth)) const BackButton(),
            Container(
                margin: size.width > mobileWidth ? const EdgeInsets.all(4) : null,
                child: CircleAvatar(
                    backgroundColor: colorScheme(context).tertiary,
                    backgroundImage: const AssetImage("assets/images/chicken.png"))),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nhóm AZFood",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "Đang hoạt động",
              style: TextStyle(
                  fontSize: 12,
                  color: colorScheme(context).scrim.withOpacity(0.6)),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCallScreen(),));
            },
            icon: Badge(
              backgroundColor: Colors.green,
              child: Icon(
                Icons.videocam_rounded,
                color: colorScheme(context).scrim.withOpacity(0.8),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard,
              color: colorScheme(context).scrim.withOpacity(0.8),
            ),
          ),
          if (size.width > mobileWidth)
            IconButton(
              onPressed: widget.onClose,
              icon: Icon(
                Icons.close,
                color: colorScheme(context).scrim.withOpacity(0.8),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          BlocListener<MessageBloc, MessageState>(
            listener: (context, state) {
              if (state is AnimateToEndState) {
                print("animate to end");
                _scrollToEnd(true);
              }
            },
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                return Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                    ),
                    child: Scrollbar(
                      controller: controllerMsg,
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        controller: controllerMsg,
                        itemCount: state.msgs.length,
                        itemBuilder: (context, index) {
                          return ItemMsg(
                              msg: state.msgs[index],
                              isMine: state.msgs[index].sendBy == profile.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          BottomActionChat(
            profile: profile,
            onSubmit: (text) {
              context.read<MessageBloc>().add(ActionSendMessage(
                  msg: Message(id: 1, sendBy: 1, message: text, type: 1)));
            },
          ),
        ],
      ),
    );
  }
}

class BottomActionChat extends StatefulWidget {
  const BottomActionChat(
      {super.key, required this.onSubmit, required this.profile});

  final Function(String) onSubmit;
  final LoginResponse profile;

  @override
  State<BottomActionChat> createState() => _BottomActionChatState();
}

class _BottomActionChatState extends State<BottomActionChat> {
  TextEditingController controllerMsg = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  Timer? typingTimer;
  bool isTyping = false;

  void startOrResetTypingTimer() {
    typingTimer?.cancel();
    typingTimer = Timer(const Duration(seconds: 3), () {
      isTyping = false;
      io.emit(SocketEvent.typedGroup, {"id": widget.profile.id});
    });
  }

  _typing() {
    if (!isTyping) {
      isTyping = true;
      io.emit(SocketEvent.typingGroup, widget.profile.toMap());
    }
    startOrResetTypingTimer();
  }

  _typed(PointerDownEvent event) {
    if (myFocusNode.hasFocus) {
      io.emit(SocketEvent.typedGroup, {"id": widget.profile.id});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 12),
      decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(30)),
      width: size.width,
      child: TextField(
        onTapOutside: (event) => _typed(event),
        onTap: _typing,
        focusNode: myFocusNode,
        onSubmitted: (value) {
          myFocusNode.requestFocus();
          setState(() {
            controllerMsg.text = '';
          });
          widget.onSubmit(value);
        },
        controller: controllerMsg,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
          _typing();
          setState(() {
            controllerMsg.text = value;
          });
        },
        decoration: InputDecoration(
            isDense: true,
            alignLabelWithHint: true,
            hintText: "Nhập tin nhắn",
            hintStyle: const TextStyle(fontSize: 16),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: InputBorder.none,
            suffixIcon: AnimatedSize(
              duration: 100.ms,
              child: controllerMsg.text == ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 24,
                            )),
                        IconButton(
                            onPressed: () async {
                              XFile? xfile =
                                  await mediaPicker(TypeMediaPicker.gallery);
                              if (xfile != null) {
                                context.read<MessageBloc>().add(
                                    ActionSendMessage(
                                        msg: Message(
                                            id: 1,
                                            sendBy: 1,
                                            imageUrl: "loading",
                                            type: 2)));
                              }
                            },
                            icon: const Icon(Icons.image, size: 24)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.keyboard_voice, size: 24)),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            color: Colors.red,
                            onPressed: () {
                              context.read<MessageBloc>().add(ActionSendMessage(
                                  msg: Message(
                                      id: 1,
                                      sendBy: 1,
                                      message: controllerMsg.text,
                                      type: 1)));
                              setState(() {
                                controllerMsg.text = '';
                              });
                            },
                            icon: const Icon(Icons.send,
                                color: Colors.pink, size: 24)),
                        const SizedBox(
                          width: 6,
                        )
                      ],
                    ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    typingTimer?.cancel();
    super.dispose();
  }
}

class ItemMsg extends StatefulWidget {
  const ItemMsg({super.key, required this.msg, this.isMine = false});

  final bool isMine;
  final Message msg;

  @override
  State<ItemMsg> createState() => _ItemMsgState();
}

class _ItemMsgState extends State<ItemMsg> {
  bool isShowUtil = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection:
                widget.isMine ? TextDirection.rtl : TextDirection.ltr,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      surfaceTintColor:
                      Colors.transparent,
                      backgroundColor:
                      Colors.transparent,
                      child: Image.network(
                          widget.msg.profile?.imgUrl ?? 'https://thumbs.dreamstime.com/b/default-placeholder-profile-icon-avatar-gray-man-90197993.jpg'),
                    ),
                  );
                },
                child: ClipOval(
                  child: Image.network(widget.msg.profile?.imgUrl ?? 'https://thumbs.dreamstime.com/b/default-placeholder-profile-icon-avatar-gray-man-90197993.jpg',
                      width: 24, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              widget.msg.statusMessage == StatusMessage.none
                  ? Column(
                      crossAxisAlignment: !widget.isMine
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.msg.profile?.name ?? '',
                          style: TextStyle(
                              fontSize: 10,
                              color:
                                  colorScheme(context).scrim.withOpacity(0.4)),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        MouseRegion(
                          onExit: (event) => setState(() {
                            isShowUtil = false;
                          }),
                          onEnter: (event) {
                            //on hover
                            setState(() {
                              isShowUtil = true;
                            });
                          },
                          child: Row(
                            children: [
                              if (widget.isMine && isShowUtil) const MsgItemUtils(),
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth: constraints.maxWidth * 0.6),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widget.msg.type == 1 ? 12 : 0,
                                      vertical: widget.msg.type == 1 ? 8 : 0),
                                  decoration: BoxDecoration(
                                      color:
                                          widget.isMine && widget.msg.type == 1
                                              ? Colors.pink
                                              : colorScheme(context).onPrimary,
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(18),
                                          topRight: const Radius.circular(18),
                                          bottomLeft: widget.isMine
                                              ? const Radius.circular(18)
                                              : const Radius.circular(0),
                                          bottomRight: !widget.isMine
                                              ? const Radius.circular(18)
                                              : const Radius.circular(0))),
                                  child: (() {
                                    switch (widget.msg.type) {
                                      case 1:
                                        return Text(
                                          widget.msg.message ?? "",
                                          style: TextStyle(
                                              color: !widget.isMine
                                                  ? colorScheme(context).scrim
                                                  : Colors.white),
                                        );
                                      case 2:
                                        return GestureDetector(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(18),
                                                topRight:
                                                    const Radius.circular(18),
                                                bottomLeft: widget.isMine
                                                    ? const Radius.circular(18)
                                                    : const Radius.circular(0),
                                                bottomRight: !widget.isMine
                                                    ? const Radius.circular(18)
                                                    : const Radius.circular(0)),
                                            child: Image.network(
                                                "https://i.pinimg.com/236x/04/ff/01/04ff010d66f96135c790846d0bf6dc4a.jpg"),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                surfaceTintColor:
                                                    Colors.transparent,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Image.network(
                                                    "https://i.pinimg.com/236x/04/ff/01/04ff010d66f96135c790846d0bf6dc4a.jpg"),
                                              ),
                                            );
                                          },
                                        );
                                      default:
                                        return Container();
                                    }
                                  }())),
                              if (!widget.isMine && isShowUtil) const MsgItemUtils(),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.msg.profile?.name} đang nhập.."),
                        Container(
                            constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * 0.6),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: widget.isMine
                                    ? Colors.pink
                                    : colorScheme(context).onPrimary),
                            child: Lottie.asset("assets/raws/typing.json",
                                width: 40, fit: BoxFit.cover)),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class MsgItemUtils extends StatefulWidget {
  const MsgItemUtils({super.key});

  @override
  State<MsgItemUtils> createState() => _MsgItemUtilsState();
}

class _MsgItemUtilsState extends State<MsgItemUtils> {
  GlobalKey motionKey = GlobalKey(debugLabel: 'motionKey');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: Transform.scale(
        scale: 0.8,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Opacity(
                    opacity: 0.8,
                    child: Icon(
                      Icons.reply,
                    ))),
            IconButton(
                key: motionKey,
                onPressed: () {
                  Position pos = getPositionByKey(motionKey);
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(pos.x, pos.y,
                          pos.size.width + pos.x, pos.y + pos.size.height),
                      items: [
                        const PopupMenuItem(
                          child: InkWell(child: Text("❤ Yêu thích")),
                        ),
                        const PopupMenuItem(
                          child: InkWell(child: Text("😆 Haha")),
                        ), const PopupMenuItem(
                          child: InkWell(child: Text("😥 Buồn")),
                        ),
                      ]);
                },
                icon: const Opacity(
                    opacity: 0.8,
                    child: Icon(
                      Icons.emoji_emotions_outlined,
                    ))),
          ],
        ),
      ),
    );
  }
}
