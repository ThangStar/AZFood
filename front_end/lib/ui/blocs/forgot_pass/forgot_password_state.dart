part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  ForgotPasswordState({this.response=const{}});
  final Map<String, dynamic> response;
  @override
  // TODO: implement props
  List<Object?> get props => [];

  ForgotPasswordState copyWith({
    Map<String, dynamic>? response,
  }) {
    return ForgotPasswordState(
      response: response ?? this.response,
    );
  }
}
class SendEmailProgress extends ForgotPasswordState{
   SendEmailProgress({super.response});
}
class SendEmailSuccess extends ForgotPasswordState{
   SendEmailSuccess({super.response});
}
class SendEmailFailed extends ForgotPasswordState{
   SendEmailFailed({super.response});
}
class SendEmailErorr extends ForgotPasswordState{
}

class VerifyOtpSuccess extends ForgotPasswordState{
   VerifyOtpSuccess({super.response});
}
class VerifyOtpFailed extends ForgotPasswordState{
   VerifyOtpFailed({super.response});
}
class VerifyOtpErorr extends ForgotPasswordState{
}

class ResetPasswordSuccess extends ForgotPasswordState{
  ResetPasswordSuccess({super.response});
}
class ResetPasswordFailed extends ForgotPasswordState{
  ResetPasswordFailed({super.response});
}
class ResetPasswordErorr extends ForgotPasswordState{
}