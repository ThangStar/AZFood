part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class ChangePasswordEvent extends ProfileEvent{

  final String oldPassword;
  final String newPassword;

  const ChangePasswordEvent({required this.oldPassword, required this.newPassword});
  List<Object?> get props => [oldPassword, newPassword];
}
