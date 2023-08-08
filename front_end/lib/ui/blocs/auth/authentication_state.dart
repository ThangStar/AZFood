part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  final Object data;
  const AuthenticationInitial({this.data = const []});
  @override
  List<Object> get props => [data];
}

class AuthLoginSuccess extends AuthenticationInitial{
  //save token to local
}

