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

class FetchUserLoading extends LoginState {
}

class FetchUserSuccess extends LoginState {
  late final UserProfile userProfile;

  FetchUserSuccess(this.userProfile);

  @override
  List<Object> get props => [userProfile];

}
class FetchUserFailure extends LoginState {
  final String error;

  const FetchUserFailure(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends LoginState {
  final String message;
  final String token;
  final String userId;

  const LoginSuccess(this.message, this.token, this.userId);

  @override
  List<Object> get props => [message, token, userId];
}

class LoginRegisterSuccess extends LoginState {
  final String username;

  const LoginRegisterSuccess(this.username);

  @override
  List<Object> get props => [username];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}