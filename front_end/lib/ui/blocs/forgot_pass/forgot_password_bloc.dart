import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../../../apis/forgot_pass/forgot_pass.api.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState()) {
    on<SendEmailEvent>(_sendEmailEvent);
  }

  FutureOr<void> _sendEmailEvent(SendEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(SendEmailProgress());
    Object result = await ForgotPassApi.forgotPassword(event.email);
    if(result is Success){
      emit(SendEmailSuccess(status: result.response.data.toString()));
      print(result.response.data);
    }else if(result is Failure){
      emit(SendEmailFailed(status: result.response!.data.toString()));
      print(result.response?.data);
    }
  }
}

