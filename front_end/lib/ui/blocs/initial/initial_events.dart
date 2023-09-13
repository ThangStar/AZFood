part of 'initial_bloc.dart';

abstract class InitialEvent extends Equatable {
  const InitialEvent();

  @override
  List<Object> get props => [];
}

class ChangePosSelectedDrawer extends InitialEvent {
  final int newPos;

  const ChangePosSelectedDrawer({required this.newPos});
}
