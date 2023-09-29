import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:restaurant_manager_app/ui/utils/size_config.dart';

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

  @override
  void initState() {
    // // TODO: implement initState
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              checkDevice(widget.constraints.maxWidth, true, false, false),
          title: Text("Lịch"),
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
              dateStringBuilder: (date, {secondaryDate}) => "aaaaaas",
              // to provide custom UI for month cells.
              cellBuilder: (date, events, isToday, isInMonth) {
                // Return your widget to display as month cell.
                return Container(
                  color: isInMonth ? Colors.white : null,
                  child: Column(
                    children: [
                      Text(
                        "${date.day}",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Icon(Ionicons.checkmark),
                    ],
                  ),
                );
              },
              minMonth: DateTime(2023),
              maxMonth: DateTime(2050),
              initialMonth: DateTime(2023),
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
        ));
  }
}
