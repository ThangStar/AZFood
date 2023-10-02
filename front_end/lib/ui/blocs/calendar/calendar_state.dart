part of 'calendar_bloc.dart';

enum CalendarStatus { success, failed, initial, progress }

class CalendarState extends Equatable {
  const CalendarState({this.status = CalendarStatus.initial});

  final CalendarStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [status];
}

class AttendanceSuccessState extends CalendarState {}

class AttendanceFailedState extends CalendarState {}

class AttendanceProgressState extends CalendarState {}
