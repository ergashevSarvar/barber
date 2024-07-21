import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/color.dart';

class CustomEasyLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EasyLoading.show(
        status: "loading".tr,
        indicator: LoadingAnimationWidget.threeArchedCircle(
          color: textYellow,
          size: 70,
        ));
    return Container();
  }
}