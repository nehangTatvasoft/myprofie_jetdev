part of 'authentication_cubit.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSucceed extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String error;
  AuthenticationError(this.error);
}

class RememberMeChanged extends AuthenticationState {}
