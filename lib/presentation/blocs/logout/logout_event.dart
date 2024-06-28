part of 'logout_bloc.dart';

@immutable
abstract class LogoutEvent extends Equatable{
  const LogoutEvent();

  @override
  List<Object> get props {
    return [];
  }

}

class LogOutRequest extends LogoutEvent {
  final String token;

  const LogOutRequest(this.token);

  @override
  List<Object> get props => [token];
}
