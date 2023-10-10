part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final Object data;
  final Profile? profile;
  const ProfileState({
    this.data = const [],
    this.profile,
  });
  @override
  List<Object> get props => [data];
}

class ChangePasswordProgress extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => [];
  //save token to local
}

class ChangePasswordSuccess extends ProfileState {}

class ChangePasswordFailed extends ProfileState {}

class ChangePasswordConnectionFailed extends ProfileState {}
