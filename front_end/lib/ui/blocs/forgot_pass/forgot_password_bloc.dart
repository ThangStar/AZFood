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
    on<ResetPasswordEvent>(_resetPasswordEvent);
  }

  FutureOr<void> _sendEmailEvent(SendEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit( SendEmailProgress());
    Object result = await ForgotPassApi.sendEmail(event.email);
    try{
      if(result is Success){
        emit(SendEmailSuccess(response: result.response.data));
        print(result.response.data);
      }else if(result is Failure){
        emit(SendEmailFailed(response: result.response!.data));
        print(result.response?.data);
      }
    }catch(e){
      emit(SendEmailErorr());
      print(e);
    }

  }

  FutureOr<void> _verifyOtpEvent(VerifyOtpEvent event, Emitter<ForgotPasswordState> emit) async {
    Object otpFromClient = event.otp;
    int? otpFromServer;
    int? otpFromEvent;
    try {
      otpFromServer = int.parse(state.response['otp'].toString());
      otpFromEvent = int.parse(otpFromClient.toString());

      if (otpFromServer == otpFromEvent) {
        emit(VerifyOtpSuccess(response: state.response));
      } else {
        emit(VerifyOtpFailed(response: state.response));
      }

    } catch (e) {
      print("Error parsing OTP values: $e");
      emit(VerifyOtpErorr());
    }
  }

  FutureOr<void> _resetPasswordEvent(ResetPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    String emailUser = state.response['email'].toString();
    Object result = await ForgotPassApi.resetPassword(event.password, emailUser);

    try{
      if(result is Success){
        emit(ResetPasswordSuccess(response: result.response.data));
        print(result.response.data['otp']);
      }else if(result is Failure){
        emit(ResetPasswordFailed(response: result.response!.data));
        print(result.response?.data);
      }
    }catch(e){
      emit(ResetPasswordErorr());
      print(e);
    }

  }
}


