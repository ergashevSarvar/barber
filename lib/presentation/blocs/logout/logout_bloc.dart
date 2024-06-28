import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogOutRequest>(_onLoginRequested);
  }
  Future<void> _onLoginRequested(LogOutRequest event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    print(event.token);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${event.token}',
      };
      final response = await http.post(
        Uri.parse('https://barbershops.pythonanywhere.com/api/logout/'),
        headers: headers,
      );
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      print(res);
      print(response.statusCode);
      if (response.statusCode == 200) {
        emit(LogoutSuccess());
      } else {
        emit(LogoutFailure('Xatolik yuzaga keldi'));
      }
    } catch (e) {
      emit(LogoutFailure('Xatolik yuzaga keldi'));
    }
  }

}
