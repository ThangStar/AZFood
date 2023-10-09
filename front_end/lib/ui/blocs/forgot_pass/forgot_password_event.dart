part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SendEmailEvent extends ForgotPasswordEvent{
  final String email;
  const SendEmailEvent({required this.email});
}

class VerifyOtpEvent extends ForgotPasswordEvent{
  final String otp;
  const VerifyOtpEvent({required this.otp});
}

class ResetPasswordEvent extends ForgotPasswordEvent{
  final String password;
  const ResetPasswordEvent({required this.password});
}
