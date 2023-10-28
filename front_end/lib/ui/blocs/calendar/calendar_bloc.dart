import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/calendar/calendar.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../../../model/attendance.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState()) {
    on<OnAttendanceEvent>(_onAttendanceEvent);
    on<OnInitAttendanceEvent>(_onInitAttendanceEvent);
  }

  FutureOr<void> _onAttendanceEvent(
      OnAttendanceEvent event, Emitter<CalendarState> emit) async {
    emit(state.copyWith(status: CalendarStatus.progress));
    Object result = await CalendarApi.attendance();
    if (result is Success) {
      if (result.response.data['isWifi']) {
        print("Verified!");
        emit(AttendanceResultState(
            status: CalendarStatus.success, attendances: state.attendances));
        add(OnInitAttendanceEvent());
      } else {
        print("Wrong wifi!");
        emit(AttendanceResultState(
            status: CalendarStatus.failed, attendances: state.attendances));
      }
    }
  }

  FutureOr<void> _onInitAttendanceEvent(
      OnInitAttendanceEvent event, Emitter<CalendarState> emit) async {
    // emit(AttendanceProgressState());
    Object result = await CalendarApi.getHistory();
    if (result is Success) {
      print("RS: ${result.response.data['resultRaw']}");
      List<dynamic> json = result.response.data['resultRaw'] as List<dynamic>;
      emit(state.copyWith(
          attendances: json.map((e) => Attendance.fromJson(e)).toList()));


      List<CalendarEventData> eventsData = [];
      eventsData.addAll(state.attendances.map((e) => CalendarEventData(
          title: "title", date: DateTime.parse(e.date ?? ""))));
      emit(state.copyWith(eventData: eventsData));

      print("length: ${state.eventData?.length}");

      emit(InitAttendanceResultState(
          status: CalendarStatus.success,
          attendances: state.attendances,
          eventData: state.eventData));

    } else {}
  }
}
