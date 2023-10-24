part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final Object data;
  final Profile? profile;
  const ProfileState({ this.data = const [], this.profile,});
  @override
  List<Object> get props => [data];

  ProfileState copyWith({
    Object? data,
    Profile? profile,
  }) {
    return ProfileState(
      data: data ?? this.data,
      profile: profile ?? this.profile,
    );
  }
}

class ChangePasswordProgress extends ProfileState {
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ProfileState {}

class ChangePasswordFailed extends ProfileState {}

class ChangePasswordConnectionFailed extends ProfileState {}

class UpdateProfileProgress extends ProfileState {
  @override
  List<Object> get props => [];
}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileFailed extends ProfileState {}

class UpdateProfileConnectionFailed extends ProfileState {}

class GetProfileLoading extends ProfileState{}
