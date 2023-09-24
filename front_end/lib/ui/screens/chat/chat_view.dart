import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
<<<<<<< Updated upstream
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/model/message.dart';
import 'package:restaurant_manager_app/model/profile.dart';
=======
>>>>>>> Stashed changes
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

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

  @override
  void initState() {
    super.initState();
    msgBloc = BlocProvider.of<MessageBloc>(context);
    // io.emit(SocketEvent.initialMessage, {"id": '123'});
    // if (!io.hasListeners(SocketEvent.onInitialMessage)) {
    //   io.on(SocketEvent.onInitialMessage, (data) {
    //     print("data init ${data}");
    //     //transform data
    //     final rs = data as List<dynamic>;
    //     rs.forEach((e) {
    //       e["status"] = "MessageStatus.read";
    //       e["createdAt"] = DateTime.now().toIso8601String();
    //       print(e);
    //       // msgs.add(e);
    //     });
    //     List<Message> msgs = rs.map((e) => Message.fromJson(e)).toList();
    msgBloc.add(InitMessageEvent());
    //   });
    // }
    _listenMessage();
  }

  _listenMessage() {
    if (!io.hasListeners(SocketEvent.onMsgGroup)) {
      io.on(SocketEvent.onMsgGroup, (data){
        print("data from sever: $data");
      });
    }
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
<<<<<<< Updated upstream
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
=======
        leadingWidth: 50,
        leading: Container(
            margin: const EdgeInsets.all(4),
            child: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/chicken.png"))),
>>>>>>> Stashed changes
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
      body: Stack(
        children: [
          BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                controller: controllerMsg,
                itemCount: state.msgs.length,
                itemBuilder: (context, index) {
                  return ItemMsg(msg: state.msgs[index]);
                },
              );
            },
          ),
          const Align(
              alignment: Alignment.bottomCenter, child: BottomActionChat()),
        ],
      ),
    );
  }
}

class BottomActionChat extends StatefulWidget {
  const BottomActionChat({super.key});

  @override
  State<BottomActionChat> createState() => _BottomActionChatState();
}

class _BottomActionChatState extends State<BottomActionChat> {
  TextEditingController controllerMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(30)),
      width: size.width,
      child: TextField(
        controller: controllerMsg,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) {
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
                            onPressed: () => context.read<MessageBloc>().add(
                                ActionSendMessage(
                                    msg: Message(
                                        id: 1,
                                        sendBy: 1,
                                        message: controllerMsg.text,
                                        type: 1))),
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
}

class ItemMsg extends StatelessWidget {
  const ItemMsg({super.key, required this.msg});

  final Message msg;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            textDirection:
                msg.sendBy == 1 ? TextDirection.rtl : TextDirection.ltr,
            children: [
              const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/avatar.jpg")),
              const SizedBox(
                width: 8,
              ),
              Container(
                constraints:
                    BoxConstraints(maxWidth: constraints.maxWidth * 0.6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: msg.sendBy == 1
                        ? Colors.pink
                        : colorScheme(context).onPrimary,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft: msg.sendBy == 1
                            ? Radius.circular(18)
                            : Radius.circular(0),
                        bottomRight: msg.sendBy != 1
                            ? Radius.circular(18)
                            : Radius.circular(0))),
                child: Text(
                  msg.message ?? "",
                  style: TextStyle(
                      color: msg.sendBy != 1
                          ? colorScheme(context).scrim
                          : colorScheme(context).onPrimary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
