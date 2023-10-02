part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({this.status=''});
  final String status;
  @override
  // TODO: implement props
  List<Object?> get props => [];

  ForgotPasswordState copyWith({
    String? status,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
    );
  }
}
class SendEmailProgress extends ForgotPasswordState{
  SendEmailProgress({super.status});
}
class SendEmailSuccess extends ForgotPasswordState{
  SendEmailSuccess({super.status});
}
class SendEmailFailed extends ForgotPasswordState{
  SendEmailFailed({super.status});
}
class SendEmailErorr extends ForgotPasswordState{
}