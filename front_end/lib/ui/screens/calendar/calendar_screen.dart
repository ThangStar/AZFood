import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:restaurant_manager_app/ui/screens/home/home_menu.dart';
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
  EventController controller = EventController();

  initEvent() {
    // CalendarControllerProvider.of(context).controller.add(event);
  }

  late CalendarBloc calendarBloc;

  initAttendance() {
    calendarBloc.add(OnInitAttendanceEvent());
  }

  @override
  void initState() {
    calendarBloc = BlocProvider.of<CalendarBloc>(context);
    initAttendance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CalendarBloc, CalendarState>(
      listener: (context, state) {
        switch (state.runtimeType) {
          case AttendanceResultState:
            if (state.status == CalendarStatus.success) {
              myAlert(context, checkDeviceType(widget.constraints.maxWidth),
                      AlertType.info, "Thông báo", "Đã điểm danh")
                  .show(context);
            } else if (state.status == CalendarStatus.failed) {
              myAlert(context, checkDeviceType(widget.constraints.maxWidth),
                      AlertType.error, "Cảnh báo", "Địa chỉ wifi không hợp lệ!")
                  .show(context);
            }
            break;
          case InitAttendanceResultState:
            {
              if (state.status == CalendarStatus.success) {
                CalendarControllerProvider.of(context)
                    .controller
                    .addAll(state.eventData ?? []);
              }
            }
        }
      },
      child: Scaffold(
          floatingActionButton: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              return FloatingActionButton.extended(
                  backgroundColor: colorScheme(context).primary,
                  onPressed: () {
                    bool isToday = state.eventData
                            .where((element) =>
                                element.date.compareWithoutTime(DateTime.now()))
                            .firstOrNull !=
                        null;
                    if (isToday) {
                      myAlert(
                              context,
                              checkDeviceType(widget.constraints.maxWidth),
                              AlertType.info,
                              "Thông tin",
                              "Hôm nay bạn đã điểm danh rồi!")
                          .show(context);
                      return;
                    }
                    context.read<CalendarBloc>().add(OnAttendanceEvent());
                  },
                  label: const Text(
                    "Điểm danh",
                    style: TextStyle(color: Colors.white),
                  ));
            },
          ),
          appBar: AppBar(
            backgroundColor: colorScheme(context).onPrimary,
            titleSpacing: checkDevice(widget.constraints.maxWidth, -5.0, 20.0, 20.0),
            automaticallyImplyLeading: false,
            leading: checkDevice(
            widget.constraints.maxWidth,
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeMenuScreen(),
                    ),
                    (route) => false);
              },
            ),
            null,
            null),
            title: Text(
              'LỊCH',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          body: Stack(
            children: [
              BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  return MonthView(
                    controller: EventController(
                      eventFilter: (date, events) => state.eventData ?? [],
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
                        leftIcon: Icon(
                          Icons.arrow_back,
                        ),
                        rightIcon: Icon(Icons.arrow_forward),
                        decoration: BoxDecoration(
                            color: colorScheme(context).onPrimary)),
                    // to provide custom UI for month cells.
                    weekDayBuilder: (day) {
                      String strDate = "";
                      switch (day) {
                        case 0:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 2"
                              : "T2";
                        case 1:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 3"
                              : "T2";

                        case 2:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 4"
                              : "T4";

                        case 3:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 5"
                              : "T5";

                        case 4:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 6"
                              : "T6";

                        case 5:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Thứ 7"
                              : "T7";

                        case 6:
                          strDate = widget.constraints.maxWidth > mobileWidth
                              ? "Chủ nhật"
                              : "CN";
                        default:
                          strDate = "Không xác định";
                      }
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            strDate,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      );
                    },
                    cellBuilder: (date, events, isToday, isInMonth) {
                      // Return your widget to display as month cell.
                      return CalendarItemDay(
                          date: date,
                          events: events,
                          isToday: isToday,
                          isInMonth: isInMonth);
                    },
                    minMonth: DateTime(2023),
                    maxMonth: DateTime(2050),
                    initialMonth: DateTime.now(),
                    cellAspectRatio: 1,
                    onPageChange: (date, pageIndex) =>
                        print("$date, $pageIndex"),
                    onCellTap: (events, date) {
                      // Implement callback when user taps on a cell.
                      print(events);
                    },
                    startDay: WeekDays.sunday,
                    // To change the first day of the week.
                    // This callback will only work if cellBuilder is null.
                    onEventTap: (event, date) => print(event),
                    onDateLongPress: (date) => print(date),
                    borderColor: colorScheme(context).background,
                  );
                },
              ),
            ],
          )),
    );
  }
}

class CalendarItemDay extends StatelessWidget {
  const CalendarItemDay(
      {super.key,
      required this.date,
      required this.events,
      required this.isToday,
      this.isInMonth});

  final DateTime date;
  final List<CalendarEventData<Object?>> events;
  final bool isToday;
  final isInMonth;

  @override
  Widget build(BuildContext context) {
    bool isChecked = events
            .where((element) => element.date.compareWithoutTime(date))
            .firstOrNull !=
        null;
    return Container(
        color: isToday && !isChecked
            ? Colors.red
            : isChecked && isToday || isChecked
                ? Colors.green[900]
                : colorScheme(context).onPrimary,
        child: Column(children: [
          Column(children: [
            Text(
              "${date.day}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: date.weekday == DateTime.sunday
                      ? Colors.red
                      : isChecked
                          ? Colors.white
                          : null),
            ),
            events.where((element) {
                      return element.date.compareWithoutTime(date);
                    }).firstOrNull !=
                    null
                ?
                // if (isToday && attendanceThisDay)
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
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ]),
        ]));
  }
}
