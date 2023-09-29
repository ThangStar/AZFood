import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

enum AlertType { success, error, info }

ElegantNotification myAlert(BuildContext context, DeviceType deviceType,
    AlertType alertType, title, content) {
  switch (alertType) {
    case AlertType.error:
      return ElegantNotification.error(
          background: colorScheme(context).background,
          progressIndicatorBackground: Colors.red[100]!,
          title: Text(
            title,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 14 : 18,
                color: Colors.red),
          ),
          height: deviceType == DeviceType.mobile ? 70 : 90,
          iconSize: deviceType == DeviceType.mobile ? 18 : 24,
          description: Text(
            content,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 12 : 14,
                color: colorScheme(context).scrim.withOpacity(0.6)),
          ));
      break;
    case AlertType.info:
      return ElegantNotification.info(
        background: colorScheme(context).background,
          progressIndicatorBackground: Colors.blue[100]!,
          title: Text(
            title,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 14 : 18,
                color: Colors.blue),
          ),
          height: deviceType == DeviceType.mobile ? 70 : 90,
          iconSize: deviceType == DeviceType.mobile ? 18 : 24,
          description: Text(
            content,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 12 : 14,
                color: colorScheme(context).scrim.withOpacity(0.6)),
          ));
      break;
    default:
      return ElegantNotification.success(
          background: colorScheme(context).background,
          progressIndicatorBackground: Colors.green[100]!,
          title: Text(
            title,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 14 : 18,
                color: Colors.green),
          ),
          height: deviceType == DeviceType.mobile ? 70 : 90,
          iconSize: deviceType == DeviceType.mobile ? 18 : 24,
          description: Text(
            content,
            style: TextStyle(
                fontSize: deviceType == DeviceType.mobile ? 12 : 14,
                color: colorScheme(context).scrim.withOpacity(0.6)),
          ));
  }
}
