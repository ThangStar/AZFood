part of 'video_call_bloc.dart';

class VideoCallEvent extends Equatable {
  const VideoCallEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnChangeUidSelected extends VideoCallEvent {
  final int uidSelected;
  OnChangeUidSelected({required this.uidSelected});
}
class ResetUidSelected extends VideoCallEvent{
}
class IncrementCounter extends VideoCallEvent{

}