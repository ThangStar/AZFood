import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_manager_app/utils/response.dart';

import '../../../apis/forgot_pass/forgot_pass.api.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super( ForgotPasswordState()) {
    on<SendEmailEvent>(_sendEmailEvent);
    on<VerifyOtpEvent>(_verifyOtpEvent);
  }

  FutureOr<void> _sendEmailEvent(SendEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit( SendEmailProgress());
    Object result = await ForgotPassApi.sendEmail(event.email);
    if(result is Success){
      emit(SendEmailSuccess(response: result.response.data));
      print(result.response.data['otp']);
    }else if(result is Failure){
      emit(SendEmailFailed(response: result.response!.data));
      print(result.response?.data);
    }
  }

  FutureOr<void> _verifyOtpEvent(VerifyOtpEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(SendEmailProgress());
    Object otpFromClient = event.otp;
    Object otpFromServer = state.response['otp'].toString();
    print(otpFromServer);
    if (state.response['otp'] == otpFromClient) {
      print('okeee');
    } else {
      print('!okeee');
    }
  }

}

