part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
}

class LoginSuccess extends LoginState {
  final String message;
  final String token;

  const LoginSuccess(this.message, this.token);

  @override
  List<Object> get props => [message, token];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}