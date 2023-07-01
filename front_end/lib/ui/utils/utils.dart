import 'package:flutter/material.dart';

Future showMyBottomSheet({required BuildContext context, required WidgetBuilder builder}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: builder
  );
}