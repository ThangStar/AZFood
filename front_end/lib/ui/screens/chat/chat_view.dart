import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/message.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

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
    // TODO: implement dispose
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
        // if (data['id'] != profile.id) {
        msgBloc.add(TypingMessageEvent(data: data));
        _scrollToEnd(true);
        // }
      });
    }

    if (!io.hasListeners(SocketEvent.onMsgTypedGroup)) {
      io.on(SocketEvent.onMsgTypedGroup, (data) {
        print(data);
        // if (data != profile.id) {
        _scrollToEnd(true);
        msgBloc.add(TypedMessageEvent(id: data));
        // }
      });
    }
  }

  _scrollToEnd(bool animate) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controllerMsg.hasClients) {
        animate
            ? controllerMsg.animateTo(controllerMsg.position.maxScrollExtent,
                duration: 500.ms, curve: Curves.fastOutSlowIn)
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
                margin: const EdgeInsets.all(4),
                child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/chicken.png"))),
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
            onPressed: () {},
            icon: Icon(
              Icons.dark_mode_outlined,
              color: colorScheme(context).scrim.withOpacity(0.8),
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
                        physics: const BouncingScrollPhysics(),
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
                            onPressed: () {},
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

class ItemMsg extends StatelessWidget {
  const ItemMsg({super.key, required this.msg, this.isMine = false});

  final bool isMine;
  final Message msg;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection: isMine ? TextDirection.rtl : TextDirection.ltr,
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg")),
              const SizedBox(
                width: 8,
              ),
              msg.statusMessage == StatusMessage.none
                  ? Container(
                      constraints:
                          BoxConstraints(maxWidth: constraints.maxWidth * 0.6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                          color: isMine
                              ? Colors.pink
                              : colorScheme(context).onPrimary,
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: isMine
                                  ? const Radius.circular(18)
                                  : const Radius.circular(0),
                              bottomRight: !isMine
                                  ? const Radius.circular(18)
                                  : const Radius.circular(0))),
                      child: Text(
                        msg.message ?? "",
                        style: TextStyle(
                            color: !isMine
                                ? colorScheme(context).scrim
                                : colorScheme(context).onPrimary),
                      ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${msg.profile?.name} đang nhập.."),
                        Container(
                            constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * 0.6),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: isMine
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
