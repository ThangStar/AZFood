import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_call_event.dart';

part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallBloc() : super(const VideoCallState()) {
    on<OnChangeUidSelected>(_onChangeUidSelected);
    on<ResetUidSelected>(_resetUidSelected);
    on<IncrementCounter>(_incrementCounter);
  }

  FutureOr<void> _onChangeUidSelected(
      OnChangeUidSelected event, Emitter<VideoCallState> emit) {
    print("CHANGED");
    emit(state.copyWith(uidSelected: event.uidSelected,counterSelected: state.counterSelected + 1));
  }

  FutureOr<void> _resetUidSelected(
      ResetUidSelected event, Emitter<VideoCallState> emit) {
    emit(state.copyWith(uidSelected: 0));
  }

  FutureOr<void> _incrementCounter(
      IncrementCounter event, Emitter<VideoCallState> emit) {
    int counter = state.counterSelected;
    ++counter;
    emit(state.copyWith(counterSelected: counter));
  }
}
