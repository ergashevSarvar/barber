part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends LoginEvent {
  final String username;
  final String password;

  const LoginRequested(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class GetUserByIdRequest extends LoginEvent {
  final String userId;
  final String token;

  const GetUserByIdRequest(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];
}