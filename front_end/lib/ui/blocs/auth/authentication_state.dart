part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final Object data;
  final Profile? profile;
  const AuthenticationState( {this.data = const [], this.profile,});
  @override
  List<Object> get props => [data];
}

class AuthLoginProgress extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object> get props => [];
  //save token to local
}

class AuthLoginSuccess extends AuthenticationState {}

class AuthLoginFailed extends AuthenticationState {}

class AuthLoginConnectionFailed extends AuthenticationState {}

class UpdateProfileProgress extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UpdateProfileSuccess extends AuthenticationState {}

class UpdateProfileFailed extends AuthenticationState {}

class UpdateProfileConnectionFailed extends AuthenticationState {}

