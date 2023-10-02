import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:restaurant_manager_app/ui/utils/my_alert.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../theme/color_schemes.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  tap() {
    print("object");
    final event = CalendarEventData(
      date: DateTime(2023, 8, 10),
      event: "Event 1",
      title: '123',
    );

    CalendarControllerProvider.of(context).controller.add(event);
  }

  bool attendanceThisDay = false;

  @override
  void initState() {
    // // TODO: implement initState
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AttendanceSuccessState:
            setState(() {
              attendanceThisDay = true;
            });
            myAlert(context, checkDeviceType(widget.constraints.maxWidth),
                    AlertType.info, "Thông báo", "Đã điểm danh")
                .show(context);
            break;
          case AttendanceFailedState:
            myAlert(context, checkDeviceType(widget.constraints.maxWidth),
                    AlertType.error, "Cảnh báo", "Địa chỉ wifi không hợp lệ!")
                .show(context);
        }
      },
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: colorScheme(context).primary,
              onPressed: () =>
                  context.read<CalendarBloc>().add(OnAttendanceEvent()),
              label: Text(
                "Điểm danh",
                style: TextStyle(color: colorScheme(context).onPrimary),
              )),
          appBar: AppBar(
            automaticallyImplyLeading:
                checkDevice(widget.constraints.maxWidth, true, false, false),
            title: Text(
              "Lịch",
              style: TextStyle(fontSize: 30),
            ),
          ),
          body: Stack(
            children: [
              MonthView(
                controller: EventController(
                  eventFilter: (date, events) => [
                    CalendarEventData(
                      date: DateTime(2023, 8, 10),
                      event: "Event 1",
                      title: '123',
                    )
                  ],
                ),
                weekDayStringBuilder: (p0) {
                  switch (p0) {
                    case 0:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 2"
                          : "T2";
                    case 1:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 3"
                          : "T2";

                    case 2:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 4"
                          : "T4";

                    case 3:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 5"
                          : "T5";

                    case 4:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 6"
                          : "T6";

                    case 5:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Thứ 7"
                          : "T7";

                    case 6:
                      return widget.constraints.maxWidth > mobileWidth
                          ? "Chủ nhật"
                          : "CN";
                    default:
                      return "Không xác định";
                  }
                },
                headerStyle: HeaderStyle(
                  leftIcon: Icon(Icons.arrow_back,),
                  rightIcon: Icon(Icons.arrow_forward),
                  decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary
                  )
                ),
                // to provide custom UI for month cells.
                cellBuilder: (date, events, isToday, isInMonth) {
                  // Return your widget to display as month cell.
                  return Container(
                    color: isToday
                        ? Colors.indigo
                        : isInMonth
                            ? colorScheme(context).background
                            : null,
                    child: Column(
                      children: [
                        Text(
                          "${date.day}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: date.weekday == DateTime.sunday
                                  ? Colors.red
                                  : isToday
                                      ? Colors.white
                                      : null),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,

                          children: [
                            if (isToday && attendanceThisDay)
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Ionicons.checkmark_circle,
                                      color: Colors.greenAccent,
                                    ),
                                    Text(
                                      "Đã điểm danh",
                                      style: TextStyle(
                                          color:
                                              colorScheme(context).onPrimary),
                                    ),
                                  ],
                                ),
                              ),
                            events[0].date == date
                                ? Text(events[0].event!)
                                : Container()
                          ],
                        )
                      ],
                    ),
                  );
                },
                minMonth: DateTime(2023),
                maxMonth: DateTime(2050),
                initialMonth: DateTime.now(),
                cellAspectRatio: 1,
                onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
                onCellTap: (events, date) {
                  // Implement callback when user taps on a cell.
                  print(events);
                },
                startDay: WeekDays.sunday,
                // To change the first day of the week.
                // This callback will only work if cellBuilder is null.
                onEventTap: (event, date) => print(event),
                onDateLongPress: (date) => print(date),
              ),
            ],
          )),
    );
  }
}
