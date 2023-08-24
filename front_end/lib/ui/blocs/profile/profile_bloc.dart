import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/model/login_result.dart';
import 'package:restaurant_manager_app/model/profile.dart';

part 'profile_events.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileState(
          status: ProfileStatus.initial,
          profile: Profile(
              id: 0,
              username: "username",
              password: "password",
              name: "name",
              role: "role",
              phoneNumber: "phoneNumber",
              email: "email"),
        )) {
    // TODO: implement event handlers
  }
}
