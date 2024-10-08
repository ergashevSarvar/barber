import 'dart:convert';

import 'package:barber/data/models/login.dart';
import 'package:barber/data/models/userProfile.dart';
import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/providers/Device_info_provider.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<GetUserByIdRequest>(_fetchUserById);
  }

  Future<bool> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    var deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final DeviceInfoProvider deviceInfoProvider = DeviceInfoProvider();
    final String deviceId = await deviceInfoProvider.getDeviceId();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int langId = prefs.getInt("langId") ?? 1;
    try {
      final response = await http.post(
        Uri.parse('https://barbershops.pythonanywhere.com/api/login/'),
        body: {
          'username': event.username,
          'password': event.password,
          'device_name' : androidInfo.model,
          'device_id' : deviceId,
          'lang' : "$langId"
        },
      );
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      print(res);
      if (res['status_code'] == 200) {
        emit(LoginSuccess(res['status_code_name'], res['token'], res['user_id']));
        prefs.setString("userId", res['user_id']);
        return true;
      } else if(res['status_code'] == 401){
        emit(LoginFailure(res['status_code_name']));
        return false;
      } else {
        emit(LoginFailure('Xatolik yuzaga keldi'));
        return false;
      }
    } catch (e) {
      emit(LoginFailure('Xatolik yuzaga keldi: ${e.toString()}'));
      return false;
    }
  }

  // @override
  // void onTransition(Transition<LoginEvent, LoginState> transition) {
  //   super.onTransition(transition);
  //   print(transition);
  // }

  Future<void> _fetchUserById(GetUserByIdRequest event, Emitter<LoginState> emit) async {
    emit(FetchUserLoading());
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${event.token}',
      };
      print("https://barbershops.pythonanywhere.com/api/users/${event.userId}");
      final response = await http.get(
        Uri.parse('https://barbershops.pythonanywhere.com/api/users/${event.userId}'),
          headers: headers
      );
      Map<String, dynamic> res = jsonDecode(utf8.decode(response.bodyBytes));
      print(res);
      if (response.statusCode == 200) {
        UserProfile userProfile = UserProfile.fromJson(res);
        emit(FetchUserSuccess(userProfile));
      } else if(response.statusCode == 401){
        emit(FetchUserFailure(res['status_code_name']));
      } else {
        emit(FetchUserFailure('Xatolik yuzaga keldi'));
      }
    } catch (e) {
      emit(FetchUserFailure('Xatolik yuzaga keldi: ${e.toString()}'));
    }
  }
}

