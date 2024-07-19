import 'package:barber/presentation/controller/language_controller.dart';
import 'package:barber/presentation/controller/page_controller.dart';
import 'package:get/get.dart';

Future<void> init() async {
  Get.put(LanguageController());
  Get.put(GetxPageController());

}