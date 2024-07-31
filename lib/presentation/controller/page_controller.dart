import 'package:get/get.dart';

class GetxPageController extends GetxController {

  RxString _currentPage = "signin".obs;
  get currentPage => _currentPage;

}