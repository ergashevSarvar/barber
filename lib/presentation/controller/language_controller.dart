import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    if (lang != null) {
      Locale locale = Locale("uz");
      if (lang == "en_US") {
        locale = Locale("en");
      } else if (lang == "uz_UZ") {
        locale = Locale("uz");
      } else if (lang == "ru_RU") {
        locale = Locale("ru");
      } else {
        locale = Locale("fr");
      }
      Get.updateLocale(locale);
    }
  }
}