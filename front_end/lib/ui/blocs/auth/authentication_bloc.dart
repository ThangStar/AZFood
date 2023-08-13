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
    Object response = await AuthApi.login(event.username, event.password);
    if (response is Success) {
      emit(AuthLoginSuccess());
      print("jsonDecode(response.data): ${jsonDecode(response.data)}");
      LoginResult loginResult = LoginResult.fromJson(response.data);
      print("loginResult: ${loginResult.username}");

      //save result to storage
      try {
        await MySharePreferences.saveData(
            KeyStorages.myProfile, jsonEncode(loginResult.toMap()));
        sleep(const Duration(seconds: 3));
      } catch (err) {
        print("err: $err");
      }

      //
      // String? a = await MySharePreferences.loadSavedData(KeyStorages.keyToken);
      // String? b = await MySharePreferences.loadSavedData(KeyStorages.keyUsername);
      // String? c = await MySharePreferences.loadSavedData(KeyStorages.keyPassword);
      // print("a,b,c: ${a} ${b} ${c}");
    } else if (response is Failure) {
      print("response.dataErr: ${response.messageErr}");
      emit(AuthLoginFailed());
    }
  }
}
