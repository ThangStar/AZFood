import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

ElegantNotification myAlert(
    BuildContext context, DeviceType type, title, content) {
  switch (type) {
    case DeviceType.mobile:
      return ElegantNotification.error(
          title: Text("Cảnh báo"),
          height: 100,
          description: Text("Không thể order bàn đang bận"));
      break;
    case DeviceType.tablet:
      return ElegantNotification.error(
          title: Text("Cảnh báo"),
          height: 100,
          description: Text("Không thể order bàn đang bận"));
      break;
    case DeviceType.pc:
      return ElegantNotification.error(
          title: Text("Cảnh báo"),
          height: 100,
          description: Text("Không thể order bàn đang bận"));
      break;
    default:
      return ElegantNotification.error(
          title: Text("Cảnh báo"),
          height: 100,
          description: Text("Không thể order bàn đang bận"));
  }
}
