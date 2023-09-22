import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';
import 'package:restaurant_manager_app/ui/widgets/my_text_field.dart';

import '../../../routers/socket.event.dart';
import '../../../utils/io_client.dart';
import '../../blocs/message/message_bloc.dart';

class ChatViewScreen extends StatefulWidget {
  const ChatViewScreen({super.key, required this.onClose});

  final VoidCallBack onClose;

  @override
  State<ChatViewScreen> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {
  late MessageBloc msgBloc;

  @override
  void initState() {
    super.initState();
    // msgBloc = BlocProvider.of<MessageBloc>(context);
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
    //     msgBloc.add(InitMessageEvent(msgs: msgs));
    //   });
    // }
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
        leading: Image.asset("assets/images/avatar.jpg"),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Văn Thắng",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              "Văn Thắng",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: colorScheme(context).scrim.withOpacity(0.8),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
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
          Text("data"),
          Align(alignment: Alignment.bottomCenter, child: BottomActionChat()),
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
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
          color: colorScheme(context).onPrimary,
          borderRadius: BorderRadius.circular(30)),
      width: size.width,
      child: TextField(
        controller: controllerMsg,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(

          isDense: true,
          alignLabelWithHint: true,
          hintText: "Nhập tin nhắn",
          hintStyle: TextStyle(
            fontSize: 16
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: InputBorder.none,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.camera_alt_outlined, size: 24,)),
              IconButton(onPressed: () {}, icon: Icon(Icons.image, size: 24)),
              IconButton(onPressed: () {}, icon: Icon(Icons.keyboard_voice, size: 24)),
              SizedBox(width: 6,)
            ],
          ),
        ),
      ),
    );
  }
}
