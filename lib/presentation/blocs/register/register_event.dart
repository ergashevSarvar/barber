part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable{

  @override
  List<Object> get props => [];
}


class RegisterRequest extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterRequest(this.username, this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object> get props => [username, email, password, firstName, lastName];
}