part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;
  final String username;

  const RegisterSuccess(this.message, this.username);

  @override
  List<Object> get props => [message, username];
}
class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object> get props => [error];
}


