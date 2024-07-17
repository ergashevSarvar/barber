import 'dart:convert';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'lang_event.dart';
part 'lang_state.dart';

class LangBloc extends Bloc<LangEvent, LangState> {
  LangBloc() : super(LangInitial()) {
    on<LangRequest>(_onLoginRequested);
    on<ChangeLangRequest>(_changeLangRequest);
  }

  Future<void> _changeLangRequest(ChangeLangRequest event, Emitter<LangState> emit) async {
    String currentLang = "fr";
    if (event.language['id'] == 1) {
      currentLang = "fr";
    } else if (event.language['id'] == 2) {
      currentLang = "ru";
    } else if (event.language['id'] == 3) {
      currentLang = "uz";
    }
    emit(LangChanged(currentLang, event.language['id']));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', currentLang);
    await prefs.setInt('langId', event.language['id']);
  }

  Future<void> _onLoginRequested(LangRequest event, Emitter<LangState> emit) async {
    emit(LangLoading());
    try {
      final response = await http.get(
        Uri.parse('https://barbershops.pythonanywhere.com/api/langs/'),
      );
      List res = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        int langId = prefs.getInt("langId") ?? 1;
        emit(LangSuccess(res, langId));
      } else {
        emit(LangFailure('Xatolik yuzaga keldi'));
      }
    } catch (e) {
      emit(LangFailure('Xatolik yuzaga keldi: ${e.toString()}'));
    }
  }
}
