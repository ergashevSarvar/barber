import 'package:barber/presentation/controller/page_controller.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/routes.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeLangPage extends StatefulWidget {
  const ChangeLangPage({super.key});

  @override
  State<ChangeLangPage> createState() => _ChangeLangPageState();
}

class _ChangeLangPageState extends State<ChangeLangPage> {

  GetxPageController getxPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kWhite,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            verticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.homePageRouter);
                    getxPageController.currentPage.value = "changeLangPage";
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: lightGrey3), borderRadius: BorderRadius.circular(50)),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                Text(
                  "chooseLang".tr,
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                horizontalSpace(18)
              ],
            )
          ],
        ),
      ),
    ));
  }
}
