import 'dart:convert';

import 'package:barber/data/models/login.dart';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../../../data/providers/Device_info_provider.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final DeviceInfoProvider deviceInfoProvider = DeviceInfoProvider();
    final String deviceId = await deviceInfoProvider.getDeviceId();
    try {
      final response = await http.post(
        Uri.parse('https://barbershops.pythonanywhere.com/api/login/'),
        body: {
          'username': event.username,
          'password': event.password,
          'device_name' : androidInfo.device,
          'device_id' : deviceId,
        },
      );
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      print(res);
      if (response.statusCode == 200) {
        emit(LoginSuccess(res['status_code_name'], res['token']));
      } else if(response.statusCode == 401){
        emit(LoginFailure('Login va parol xato kiritildi'));
      } else {
        emit(LoginFailure('Xatolik yuzaga keldi'));
      }
    } catch (e) {
      emit(LoginFailure('Xatolik yuzaga keldi'));
    }
  }
}

