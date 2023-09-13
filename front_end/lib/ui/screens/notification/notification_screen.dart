import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/model/notification.dart' as Noti;

import '../../theme/color_schemes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Noti.Notification> notifications = [
    Noti.Notification(
        id: 0,
        content: "content",
        assetImage: "assets/images/avatar.jpg",
        opened: false, date: '25-5-2002')
  ];

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
                  // isRead = List.generate(10, (index) => true);
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
                Noti.Notification notification = notifications[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // isRead[index] = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    color: notification.opened
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
                                  notification.content,
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
                                  notification.date,
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
                                _showBottomSheet(context);
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.mark_email_read),
              title: const Text('Đánh dấu đã đọc'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Xóa thông báo này'),
              onTap: () {
                setState(() {
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
