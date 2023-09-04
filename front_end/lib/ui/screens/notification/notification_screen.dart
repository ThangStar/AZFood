import 'package:flutter/material.dart';

import '../../theme/color_schemes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notifications = [
    "Lorem Ipsum is simply dummy text...",
    "Bia Larue đã hết",
    "Món đậu phụ luộc đã hết",
    "Món Tôm chiên giòn đã hết",
    "Bia Tiger còn 1 thùng",
    "Món Cơm chiên trứng đã hết",
    "Bia Tiger còn 1 thùng",
    "Món Cơm chiên trứng đã hết",
    "Bia Tiger còn 1 thùng",
    "Món Cơm chiên trứng đã hết",
  ];

  List<String> date = [
    "12/6/2023",
    "12/6/2023",
    "12/6/2023",
    "12/6/2023",
    "10/6/2023",
    "12/6/2023",
    "12/6/2023",
    "10/6/2023",
    "12/6/2023",
    "10/6/2023",
  ];

  List<bool> isRead = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isRead = List.generate(
                      10, (index) => true);
                });
              },
              child: Text(
                'Đánh dấu tất cả',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                String notificationText = notifications[index];
                if (notificationText.length > 80) {
                  notificationText = '${notificationText.substring(0, 80)}...';
                }
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isRead[index] = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    color: isRead[index]
                        ? colorScheme(context).onPrimary
                        : colorScheme(context).outline.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  AssetImage('assets/images/avatar.jpg'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notificationText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: colorScheme(context).scrim,
                                      ),
                                ),
                                Text(
                                  date[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontSize: 12,
                                        color: colorScheme(context).scrim,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, index);
                              },
                              child: const Icon(Icons.more_horiz),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.mark_email_read),
              title: const Text('Đánh dấu đã đọc'),
              onTap: () {
                setState(() {
                  isRead[index] = true;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Xóa thông báo này'),
              onTap: () {
                setState(() {
                  notifications.removeAt(index);
                  date.removeAt(index);
                  isRead.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
