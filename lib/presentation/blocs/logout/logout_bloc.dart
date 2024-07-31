import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../data/providers/Device_info_provider.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<LogOutRequest>(_onLogutRequested);
  }

  Future<void> _onLogutRequested(LogOutRequest event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final DeviceInfoProvider deviceInfoProvider = DeviceInfoProvider();
    final String deviceId = await deviceInfoProvider.getDeviceId();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${event.token}',
      };
      final response = await http.post(
        Uri.parse('https://barbershops.pythonanywhere.com/api/logout/'),
        // body: {
        //   'device_name' : androidInfo.model,
        //   'device_id' : deviceId,
        // },
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
