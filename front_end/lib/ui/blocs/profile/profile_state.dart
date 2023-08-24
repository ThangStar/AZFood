part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  const ProfileState({
    required this.status,
    this.error,
    required this.profile
  });

  final ProfileStatus status;
  final String? error;
  final Profile profile;

  @override
  List<Object?> get props => [status, error];

  ProfileState copyWith({
    ProfileStatus? status,
    String? error,
    Profile? profile
  }) {
    return ProfileState(
      status: status ?? this.status,
      error: error, profile: this.profile,
    );
  }
}
