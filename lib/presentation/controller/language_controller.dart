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
      if (lang == "en") {
        locale = Locale("en");
      } else if (lang == "uz") {
        locale = Locale("uz");
      } else if (lang == "ru") {
        locale = Locale("ru");
      } else {
        locale = Locale("fr");
      }
      Get.updateLocale(locale);
    } else {
      prefs.setString('lang', 'uz');
      Locale locale = Locale("uz");
      Get.updateLocale(locale);
    }
  }
}