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
  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class UpdateProfileEvent extends ProfileEvent{

  final String email;
  final String phoneNumber;
  final String imgUrl;
  final String birtDay;

  const UpdateProfileEvent({required this.email, required this.phoneNumber, required this.imgUrl, required this.birtDay});
  @override
  List<Object?> get props => [email, phoneNumber, imgUrl, birtDay];
}
class GetProfileEvent extends ProfileEvent{
  final int id;
  const GetProfileEvent({required this.id});
}

