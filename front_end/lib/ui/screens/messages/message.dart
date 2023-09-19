import 'package:flutter/material.dart';

class Message {
  final String content;
  final bool isFromMe;
  final DateTime timestamp;

  Message(this.content, this.isFromMe, this.timestamp);
}
int? selectedMessageIndex;
class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key}) : super(key: key);
  @override
  _MessageScreenState createState() => _MessageScreenState();

}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> messages = [
    Message('Xin chào!', false, DateTime.now().subtract(Duration(minutes: 15))),
    Message('Chào bạn!', true, DateTime.now().subtract(Duration(minutes: 10))),
    Message('Làm gì đó?', false, DateTime.now().subtract(Duration(minutes: 5))),
    Message('Đang code Flutter.', true,
        DateTime.now().subtract(const Duration(minutes: 2))),
    Message('Chào bạn!', true, DateTime.now().subtract(const Duration(minutes: 10))),
    Message('Làm gì đó?', false, DateTime.now().subtract(const Duration(minutes: 5))),
    Message(
        ' Đang code FlutterĐang code FlutterĐang code FlutterĐang code FlutterĐang code Flutter.',
        true,
        DateTime.now().subtract(const Duration(minutes: 2))),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (selectedMessageIndex != null) {
          setState(() {
            selectedMessageIndex = null;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tin nhắn nhóm',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedMessageIndex == index) {
                            selectedMessageIndex = null;
                          } else {
                            selectedMessageIndex = index;
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: messages[index].isFromMe ? 50 : 10,
                              right: messages[index].isFromMe ? 10 : 50,
                            ),
                            child: Row(
                              mainAxisAlignment: messages[index].isFromMe
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                if (!messages[index].isFromMe)
                                  CircleAvatar(
                                    child: Icon(Icons.person),
                                    radius: 20,
                                  ),
                                const SizedBox(width: 10),
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                    color: messages[index].isFromMe
                                        ? Colors.blue[200]
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(messages[index].content),
                                ),
                              ],
                            ),
                          ),
                          if (selectedMessageIndex == index)
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                messages[index].timestamp.toLocal().toString(),
                                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 16), // Đặt cỡ chữ cho TextField
                      decoration: InputDecoration(
                        hintText: 'Nhắn tin',
                        hintStyle: const TextStyle(fontSize: 16), // Đặt cỡ chữ cho hintText
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: (40-16)/2, horizontal: 10), // Đặt chiều cao cho TextField. Trừ đi cỡ chữ để căn giữa
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: (){
                        if(_controller.text.isNotEmpty){
                          setState(() {
                            messages.add(Message(_controller.text, true, DateTime.now()));
                            _controller.clear();
                          });
                        }
                      },
                      icon: const Icon(Icons.send)
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
