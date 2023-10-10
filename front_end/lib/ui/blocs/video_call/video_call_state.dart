part of 'video_call_bloc.dart';

class VideoCallState extends Equatable {
  final int uidSelected;
  const VideoCallState({this.uidSelected = 0});
  @override
  // TODO: implement props
  List<Object?> get props => [uidSelected];

  VideoCallState copyWith({
    int? uidSelected,
  }) {
    return VideoCallState(
      uidSelected: uidSelected ?? this.uidSelected,
    );
  }
}

class ResetValueState extends VideoCallState{}
