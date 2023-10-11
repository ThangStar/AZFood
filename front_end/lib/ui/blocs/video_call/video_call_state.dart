part of 'video_call_bloc.dart';

class VideoCallState extends Equatable {
  final int uidSelected;
  final int counterSelected;

  const VideoCallState({this.uidSelected = 0, this.counterSelected = 0});

  @override
  // TODO: implement props
  List<Object?> get props => [uidSelected];

  VideoCallState copyWith({
    int? uidSelected,
    int? counterSelected,
  }) {
    return VideoCallState(
      uidSelected: uidSelected ?? this.uidSelected,
      counterSelected: counterSelected ?? this.counterSelected,
    );
  }
}

class ResetValueState extends VideoCallState {}
