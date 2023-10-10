import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_call_event.dart';

part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallBloc() : super(const VideoCallState()) {
    on<OnChangeUidSelected>(_onChangeUidSelected);
    on<ResetUidSelected>(_resetUidSelected);
  }

  FutureOr<void> _onChangeUidSelected(
      OnChangeUidSelected event, Emitter<VideoCallState> emit) {
    print("CHANGED");
    emit(state.copyWith(uidSelected: event.uidSelected));
  }

  FutureOr<void> _resetUidSelected(
      ResetUidSelected event, Emitter<VideoCallState> emit) {
    emit(ResetValueState());
  }
}
