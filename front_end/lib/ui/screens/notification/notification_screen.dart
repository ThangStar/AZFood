import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../theme/color_schemes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Danh sách thông báo
  final List<String> notifications = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galle",
    "Bia Larue đã hết",
    "Món đậu phụ luộc đã hết",
    "Món Tôm chiên giòn đã hết",
    "Bia Tiger còn 1 thùng",
    "Món Cơm chiên trứng đã hết",
  ];

  final List<String> date = [
    "12/6/2023",
    "12/6/2023",
    "12/6/2023",
    "12/6/2023",
    "10/6/2023",
    "12/6/2023",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).background,
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                'Đánh dấu đã đọc',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                                        fontSize: 16)
                                    ?.copyWith(
                                        color: colorScheme(context).scrim),
                              ),
                              Text(
                                date[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontSize: 12)
                                    ?.copyWith(
                                        color: colorScheme(context)
                                            .scrim
                                            .withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
