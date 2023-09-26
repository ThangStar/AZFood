// Create an instance of Windows Notification with your application name
// application id must be null in packaged mode
// import 'package:quick_notify/quick_notify.dart';

import 'package:local_notifier/local_notifier.dart';

Future<void> showNotiWindow() async {
  LocalNotification notification = LocalNotification(
    title: "Tin nhắn mới",
    body: "Anh đang làm gì thế ❤",
    actions: [
      LocalNotificationAction(
        text: "Trả lời",
      ),
      LocalNotificationAction(
          text: "Đóng"
      ),
    ]
  );
  notification.onShow = () {
    print('onShow ${notification.identifier}');
  };
  notification.onClose = (closeReason) {
    // Only supported on windows, other platforms closeReason is always unknown.
    switch (closeReason) {
      case LocalNotificationCloseReason.userCanceled:
        // do something
        break;
      case LocalNotificationCloseReason.timedOut:
        // do something
        break;
      default:
    }
  };
  notification.onClick = () {
    print('onClick ${notification.identifier}');
  };
  notification.onClickAction = (actionIndex) {
    //actionIndex is pos noti :)
    print('onClickAction ${notification.identifier} - $actionIndex');
  };

  notification.show();
}
