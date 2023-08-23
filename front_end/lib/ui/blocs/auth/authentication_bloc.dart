import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/apis/auth/auth.api.dart';
import 'package:restaurant_manager_app/constants/key_storages.dart';
import 'package:restaurant_manager_app/model/login_result.dart';
import 'package:restaurant_manager_app/storage/share_preferences.dart';
import 'package:restaurant_manager_app/utils/response.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationState()) {
    on<LoginAutEvent>(_loginAuthEvent);
  }

  FutureOr<void> _loginAuthEvent(
      LoginAutEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoginProgress());
    Object result = await AuthApi.login(event.username, event.password);
    if (result is Success) {
      emit(AuthLoginSuccess());
      // print("jsonDecode(response.data): ${jsonDecode(response.data)}");
      // LoginResult loginResult = LoginResult.fromJson(jsonEncode(response.data));
      // print("loginResult: ${loginResult.username}");
      // final a  = response.data as dynamic;

      //save result to storage
      try {
        // print(result.response);  
        // await MySharePreferences.saveData(
        //     KeyStorages.myProfile, jsonEncode(loginResult.toMap()));
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
}
