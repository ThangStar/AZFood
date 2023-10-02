import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_manager_app/ui/theme/color_schemes.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

import '../../blocs/calendar/calendar_bloc.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            checkDevice(widget.constraints.maxWidth, true, false, false),
        title: Text("Lịch đi làm tuần này", style: TextStyle(fontSize: 28)),
      ),
      body: Stack(
        children: [
          WeekView(
            controller: EventController(),
            backgroundColor: colorScheme(context).background,
            headerStringBuilder: (date, {secondaryDate}) {
              return "${DateFormat('dd-MM-yyyy').format(date)} đến ${DateFormat('dd-MM-yyyy').format(secondaryDate!)}";
            },
          ),
        ],
      ),
    );
  }
}
