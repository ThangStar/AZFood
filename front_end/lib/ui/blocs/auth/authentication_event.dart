part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> get props => [];
}

class LoginAutEvent extends AuthenticationEvent{
  final String username;
  final String password;

  const LoginAutEvent({required this.username, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [username, password];
}

