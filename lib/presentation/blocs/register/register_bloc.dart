import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/providers/Device_info_provider.dart';
import '../login/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterRequest>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(RegisterRequest event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final DeviceInfoProvider deviceInfoProvider = DeviceInfoProvider();
    final String deviceId = await deviceInfoProvider.getDeviceId();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int langId = prefs.getInt("langId") ?? 1;
    try {
      final response = await http.post(
        Uri.parse('https://barbershops.pythonanywhere.com/api/register/'),
        body: {
          'username': event.username,
          'email': event.email,
          'password' : event.password,
          'first_name' : event.firstName,
          'last_name' : event.lastName,
          'lang' : "$langId"
        },
      );
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      print(res);
      if (res['status_code'] == 202) {
        emit(RegisterSuccess(res['status_code_name'], event.username));
      } else if(res['status_code'] == 101 || res['status_code'] == 100 || res['status_code'] == 103){
        emit(RegisterFailure(res['status_code_name']));
      } else if(response.statusCode == 400){
        emit(RegisterFailure(res.toString()));
      } else {
        emit(RegisterFailure('Xatolik yuzaga keldi'));
      }
    } catch (e) {
      emit(RegisterFailure('Xatolik yuzaga keldi: ${e.toString()}'));
    }
  }

}
