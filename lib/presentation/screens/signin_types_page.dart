import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';
import '../../utils/color.dart';
import '../blocs/langs/lang_bloc.dart';
import '../widgets/divider.dart';

class SigninTypesPage extends StatefulWidget {
  const SigninTypesPage({super.key});

  @override
  State<SigninTypesPage> createState() => _SigninTypesPageState();
}

class _SigninTypesPageState extends State<SigninTypesPage> {

  Image getLangFlag(int id) {
    String path = "assets/images/uzbek_flag.png";
    if (id == 2) path = "assets/images/rus_flag.png";
    return Image.asset(
      path,
      width: 30,
    );
  }

  Future<String> getLangImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? "uz";
    String path = "assets/images/uzbek_flag.png";
    if (lang == "ru") path = "assets/images/rus_flag.png";
    return path;
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Image.asset("assets/images/logo.png", width: 200),
                      Text(
                        "signin".tr.toUpperCase(),
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      verticalSpace(30),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(width: 1, color: lightGrey), borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/google.png", width: 30),
                            Text(
                              "withGoogle".tr,
                              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container()
                          ],
                        ),
                      ),
                      verticalSpace(25),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border.all(width: 1, color: lightGrey), borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset("assets/images/telegram.png", width: 30),
                            Text(
                              "withTelegram".tr,
                              style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container()
                          ],
                        ),
                      ),
                      verticalSpace(25),
                      CustomDivider("or".tr, textGrey, FontWeight.w400),
                      verticalSpace(25),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signinPage);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(color: textYellow, borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Text(
                            "withPassword".tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(color: kWhite, fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                      ),
                      verticalSpace(75),
                      GestureDetector(
                        onTap: (){
                          context.read<LangBloc>().add(LangRequest());
                          showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                              builder: (context) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 280,
                                  child: Column(
                                    children: [
                                      Text(
                                        "chooseLang".tr,
                                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                                      verticalSpace(10),
                                      BlocConsumer<LangBloc, LangState>(builder: (context, state) {
                                        if (state is LangLoading) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 60),
                                            child: Center(child: LoadingAnimationWidget.threeArchedCircle(color: textYellow, size: 48)),
                                          );
                                        } else if (state is LangSuccess) {
                                          return ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1.5, color: state.lang[index]['id'].toString() == "langId".tr ? textYellow : lightGrey),
                                                      color: state.lang[index]['id'].toString() == "langId".tr ? textYellowLight : null,
                                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                                  child: ListTile(
                                                    onTap: () {
                                                      _changeLang(state.lang[index], context);
                                                    },
                                                    title: Text(state.lang[index]['language'], style: GoogleFonts.montserrat(fontSize: 18)),
                                                    leading: getLangFlag(state.lang[index]['id']),
                                                    trailing: state.lang[index]['id'].toString() == "langId".tr ? Icon(Icons.check_circle_rounded, color: textYellow) : null,
                                                  ),
                                                );
                                              },
                                              separatorBuilder: (context, index) {
                                                return Container();
                                              },
                                              itemCount: state.lang.length);
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
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: lightGrey), borderRadius: BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if ("langId".tr == "1" || "langId".tr == "3") ...[
                                Image.asset("assets/images/uzbek_flag.png", width: 30),
                              ],
                              if ("langId".tr == "2") ...[
                                Image.asset("assets/images/rus_flag.png", width: 30),
                              ],
                              Text(
                                "lang".tr,
                                style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Icon(Icons.arrow_drop_down_rounded, size: 26)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "newUser".tr + " ",
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.registerPage);
                        },
                        child: Text(
                          "register".tr,
                          style: GoogleFonts.montserrat(color: textYellow, fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
