part of 'calendar_bloc.dart';

enum CalendarStatus { success, failed, initial, progress }

class CalendarState extends Equatable {
  const CalendarState(
      {this.status = CalendarStatus.initial,
      this.attendances = const [],
      this.eventData = const []});

  final CalendarStatus status;
  final List<Attendance> attendances;
  final List<CalendarEventData> eventData;

  @override
  List<Object?> get props => [status, attendances, eventData];

  CalendarState copyWith({
    CalendarStatus? status,
    List<Attendance>? attendances,
    List<CalendarEventData>? eventData,
  }) {
    return CalendarState(
      status: status ?? this.status,
      attendances: attendances ?? this.attendances,
      eventData: eventData ?? this.eventData,
    );
  }
}

class AttendanceResultState extends CalendarState {
  const AttendanceResultState({super.status, super.attendances, super.eventData});
}

class InitAttendanceResultState extends CalendarState {
  const InitAttendanceResultState(
      {super.status, super.attendances, super.eventData});
}
