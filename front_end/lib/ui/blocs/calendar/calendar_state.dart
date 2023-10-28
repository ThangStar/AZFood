part of 'calendar_bloc.dart';

enum CalendarStatus { success, failed, initial, progress }

class CalendarState extends Equatable {
  const CalendarState(
      {this.status = CalendarStatus.initial, this.attendances = const []});

  final CalendarStatus status;
  final List<Attendance> attendances;

  @override
  // TODO: implement props
  List<Object?> get props => [status, attendances];

  CalendarState copyWith({
    CalendarStatus? status,
    List<Attendance>? attendances,
  }) {
    return CalendarState(
      status: status ?? this.status,
      attendances: attendances ?? this.attendances,
    );
  }
}

class AttendanceResultState extends CalendarState {
  const AttendanceResultState({super.status, super.attendances});
}

