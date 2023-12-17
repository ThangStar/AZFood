import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/auth/auth.api.dart';
import 'package:restaurant_manager_app/apis/profile/profile.api.dart';
import 'package:restaurant_manager_app/model/login_response.dart';
import 'package:restaurant_manager_app/model/profile.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/utils/response.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

int? id;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<LoginAutEvent>(_loginAuthEvent);
    on<UpdateProfileEvent>(_updateProfileEvent);
  }

  FutureOr<void> _loginAuthEvent(
      LoginAutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoginProgress());
    Object result = await AuthApi.login(event.username, event.password);
    if (result is Success) {
      emit(AuthLoginSuccess());
      LoginResponse loginResult = LoginResponse.fromJson(result.response.toString());
      //transform data
      loginResult.password = event.password;
      try {
        await MySharePreferences.saveProfile(loginResult.toJson());
        await _loadProfile(loginResult.id, emit);
        id = loginResult.id;
      } catch (err) {
        print("err: $err");
      }
    } else if (result is Failure) {
      print(result.response);
      if (result.response?.data == null) {
        print("mat ket noi may chu");
        emit(AuthLoginConnectionFailed());
      } else {
        print("tk mk k chinh xac");
        emit(AuthLoginFailed());
      }
    }
  }

  FutureOr<void> _updateProfileEvent(
      UpdateProfileEvent event, Emitter<AuthenticationState> emit) async {
    emit(UpdateProfileProgress());
    Object result = await ProfileApi.updateProfile(event.email, event.phoneNumber, event.imgUrl, event.birtDay);
    if (result is Success) {
      emit(UpdateProfileSuccess());
      try{
        await _loadProfile(id?? 0, emit);
      }catch(err){
        print("err: ${err}");
      }
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

  Future<void> _loadProfile( int id, Emitter<AuthenticationState> emit) async {
    try {
      Object result = await ProfileApi.getProfile(id);
      if (result is Success) {
        print('sucess ${result.response}');
        Profile profile = Profile.fromJson(jsonDecode(result.response.toString()));
        emit(AuthenticationState(profile: profile));
      } else if (result is Failure) {
        print("failure");
      }
    } catch (e) {
      print("err $e");
    }
  }
}
