import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/calendar/calendar.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(const CalendarState()) {
    on<OnAttendanceEvent>(_onAttendanceEvent);
  }

  FutureOr<void> _onAttendanceEvent(
      OnAttendanceEvent event, Emitter<CalendarState> emit) async {
    emit(AttendanceProgressState());
    Object result = await CalendarApi.attendance();
    if (result is Success) {
      if (result.response.data['isWifi']) {
        print("Verified!");
        emit(AttendanceSuccessState());
      } else {
        print("Wrong wifi!");
        emit(AttendanceFailedState());
      }
    }
  }
}
