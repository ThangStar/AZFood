import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'initial_events.dart';
part 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialState> {
  InitialBloc()
      : super(const InitialState(
          status: InitialStatus.initial,
        )) {
    on<ChangePosSelectedDrawer>(_changePosSelectedDrawer);
  }

  FutureOr<void> _changePosSelectedDrawer(
      ChangePosSelectedDrawer event, Emitter<InitialState> emit) {
    emit(state.copyWith(posDrawerSelected: event.newPos));
  }
}
