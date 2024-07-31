import 'package:barber/presentation/controller/page_controller.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/routes.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/langs/lang_bloc.dart';

class ChangeLangPage extends StatefulWidget {
  const ChangeLangPage({super.key});

  @override
  State<ChangeLangPage> createState() => _ChangeLangPageState();
}

class _ChangeLangPageState extends State<ChangeLangPage> {
  GetxPageController getxPageController = Get.find();

  Future<String> getLangImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? "uz";
    String path = "assets/images/uzbek_flag.png";
    if (lang == "ru") path = "assets/images/rus_flag.png";
    return path;
  }

  Image getLangFlag(int id) {
    String path = "assets/images/uzbek_flag.png";
    if (id == 2) path = "assets/images/rus_flag.png";
    return Image.asset(
      path,
      width: 30,
    );
  }

  void _changeLang(Map<String, dynamic> lang, BuildContext context) async {
    Locale locale = Locale("fr");
    String currentLang = "fr";
    if (lang['id'] == 1) {
      locale = Locale('fr');
      currentLang = "fr";
    }
    if (lang['id'] == 2) {
      locale = Locale('ru');
      currentLang = "ru";
    }
    if (lang['id'] == 3) {
      locale = Locale('uz');
      currentLang = "uz";
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', currentLang);
    await prefs.setInt('langId', lang['id']);
    Get.updateLocale(locale);
    Future.delayed(Duration(microseconds: 300), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {

    super.initState();
  }

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
                    Navigator.of(context).pop();
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
                horizontalSpace(18),
              ],
            ),
            verticalSpace(30),
            BlocConsumer<LangBloc, LangState>(builder: (context, state) {
              if (state is LangLoading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(child: LoadingAnimationWidget.threeArchedCircle(color: textYellow, size: 48)),
                );
              } else if (state is LangSuccess) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: lightGrey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            _changeLang(state.lang[index], context);
                          },
                          // leading: getLangFlag(state.lang[index]['id']),
                          title: Text(state.lang[index]['language'], style: GoogleFonts.montserrat(fontSize: 18)),
                          trailing: state.lang[index]['id'].toString() == "langId".tr ? Icon(Icons.check_circle_rounded, color: textYellow) : null,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: lightGrey, width: 1))),
                        );
                      },
                      itemCount: state.lang.length),
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is LangChanged) {
                EasyLoading.dismiss();
                Navigator.of(context).pop();
              }
              if (state is LangFailure) {
                EasyLoading.dismiss();
                Get.snackbar(
                  "warning".tr,
                  "Tillarni tortishda xatolik yuz berdi",
                  isDismissible: true,
                  duration: Duration(milliseconds: 2000),
                  icon: Icon(Icons.warning_rounded, color: kTextDanger, size: 28),
                  overlayBlur: 1,
                );
              }
            })
          ],
        ),
      ),
    ));
  }
}
