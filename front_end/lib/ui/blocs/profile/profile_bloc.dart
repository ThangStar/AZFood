import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/apis/profile/profile.api.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<ChangePasswordEvent>(_changePasswordEvent);
    on<UpdateProfileEvent>(_updateProfileEvent);
    on<GetProfileEvent>(_getProfileEvent);
  }
    FutureOr<void> _changePasswordEvent(
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

  FutureOr<void> _updateProfileEvent(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(UpdateProfileProgress());
    Object result = await ProfileApi.updateProfile(event.email, event.phoneNumber, event.imgUrl, event.birtDay);
    if (result is Success) {
      emit(UpdateProfileSuccess());
      print("Cap nhat thong tin thanh cong.");
    } else if (result is Failure) {
      print(result.response);
      if (result.response?.data == null) {
        print("Mat ket noi may chu.");
        emit(UpdateProfileConnectionFailed());
      } else {
        print("Thong tin nguoi dung khong chinh xac.");
        emit(UpdateProfileFailed());
      }
    }
  }

  FutureOr<void> _getProfileEvent(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(GetProfileLoading());
     try {
      Object result = await ProfileApi.getProfile(event.id);
      if (result is Success) {
        Profile profile = Profile.fromJson(jsonDecode(result.response.toString()));
        emit(ProfileState(profile: profile));
      } else if (result is Failure) {
        print("failure");
      }
    } catch (e) {
      print("err $e");
    }
  }
}
