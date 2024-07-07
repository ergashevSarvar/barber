import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CustomEasyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EasyLoading.show(status: "loading".tr);
    return Container();
  }
}