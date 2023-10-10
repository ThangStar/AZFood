import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/apis/profile/profile.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ChangePasswordEvent>(_updateProfileEvent);
  }
    FutureOr<void> _updateProfileEvent(
      ChangePasswordEvent event, Emitter<ProfileState> emit) async {
    emit(ChangePasswordProgress());
    Object result = await ProfileApi.updatePassword(event.oldPassword, event.newPassword);
    if (result is Success) {
      emit(ChangePasswordSuccess());
      print("check mk thanh cong");
    } else if (result is Failure) {
      print(result.response);
      if (result.response?.data == null) {
        print("mat ket noi may chu");
        emit(ChangePasswordConnectionFailed());
      } else {
        print("mk k chinh xac");
        emit(ChangePasswordFailed());
      }
    }
  }
}
