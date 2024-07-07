import 'package:barber/presentation/blocs/langs/lang_bloc.dart';
import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/blocs/register/register_bloc.dart';
import 'package:barber/presentation/widgets/divider.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';
import '../../utils/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _showHidePassword = true;

  void showHidePassword() {
    setState(() {
      _showHidePassword = !_showHidePassword;
    });
  }

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          EasyLoading.show(status: "loading".tr);
        } else if (state is LoginSuccess) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, Routes.home);
          Get.snackbar(
            "successful".tr,
            state.message,
            isDismissible: true,
            duration: Duration(milliseconds: 1500),
            icon: Icon(Icons.check_circle, color: kTextSuccess, size: 28),
            overlayBlur: 0,
          );
        } else if (state is LoginFailure) {
          EasyLoading.dismiss();
          Get.snackbar(
            "warning".tr,
            state.error,
            isDismissible: true,
            duration: Duration(milliseconds: 2000),
            icon: Icon(Icons.warning_rounded, color: kTextDanger, size: 28),
            overlayBlur: 1,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: lightGrey,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(margin: EdgeInsets.only(top: 30), child: Icon(Icons.lock, size: 126, color: darkGrey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          "welcome".tr,
                          style: GoogleFonts.montserrat(fontSize: 20, color: textGrey, fontWeight: FontWeight.w500),
                        ),
                        verticalSpace(15),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return TextFormField(
                              initialValue: state is RegisterSuccess ? "${state.username}" : "sarvar",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "enterLogin".tr;
                                }
                                return null;
                              },
                              onSaved: (value) => _username = value!,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffE7E7E7),
                                labelText: "enterLogin".tr,
                                labelStyle: GoogleFonts.montserrat(color: textGrey),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
                              ),
                            );
                          },
                        ),
                        verticalSpace(15),
                        TextFormField(
                          initialValue: "1",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "enterPassword".tr;
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                          obscureText: _showHidePassword,
                          decoration: InputDecoration(
                            filled: true,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  showHidePassword();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 13),
                                  child: _showHidePassword ? FaIcon(FontAwesomeIcons.eye, size: 20) : FaIcon(FontAwesomeIcons.eyeLowVision, size: 20),
                                )),
                            suffixIconColor: textGrey,
                            fillColor: Color(0xffE7E7E7),
                            labelText: "enterPassword".tr,
                            labelStyle: GoogleFonts.montserrat(color: textGrey),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "forgetPassword".tr,
                                  style: GoogleFonts.montserrat(color: textGrey, fontSize: 18, fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(color: darkGrey, borderRadius: BorderRadius.circular(6)),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                BlocProvider.of<LoginBloc>(context).add(
                                  LoginRequested(_username, _password),
                                );
                              }
                            },
                            child: Text(
                              "signin".tr.toUpperCase(),
                              style: GoogleFonts.montserrat(color: kWhite, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomDivider("additionalLinks".tr, textGrey, FontWeight.w400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: lightGrey2, border: Border.all(width: 1, color: kWhite), borderRadius: BorderRadius.all(Radius.circular(16))),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/google.png", width: 40),
                        // child: Icon(Icons.add),
                      ),
                      horizontalSpace(20),
                      Container(
                        decoration: BoxDecoration(color: lightGrey2, border: Border.all(width: 1, color: kWhite), borderRadius: BorderRadius.all(Radius.circular(16))),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/telegram.png", width: 40),
                        // child: Icon(Icons.add),
                      ),
                      horizontalSpace(20),
                      GestureDetector(
                        onTap: () {
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
                                            child: Center(child: CircularProgressIndicator()),
                                          );
                                        } else if (state is LangSuccess) {
                                          return ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 1.5, color: state.lang[index]['id'] == state.langId ? color2022 : lightGrey),
                                                      color: state.lang[index]['id'] == state.langId ? Color(0x206463b1) : null,
                                                      borderRadius: BorderRadius.all(Radius.circular(8))),
                                                  child: ListTile(
                                                    onTap: () {
                                                      _changeLang(state.lang[index], context);
                                                    },
                                                    title: Text(state.lang[index]['language'], style: GoogleFonts.montserrat(fontSize: 18)),
                                                    leading: getLangFlag(state.lang[index]['id']),
                                                    trailing: state.lang[index]['id'] == state.langId ? Icon(Icons.check_circle_rounded, color: color2022) : null,
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
                            decoration: BoxDecoration(color: lightGrey2, border: Border.all(width: 1, color: kWhite), borderRadius: BorderRadius.all(Radius.circular(16))),
                            padding: EdgeInsets.all(12),
                            child: FutureBuilder<String>(
                                future: getLangImage(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  return Image.asset(snapshot.data ?? "assets/images/uzbek_flag.png", width: 40);
                                })
                            // child: Icon(Icons.add),
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "newUser".tr + " ",
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.register);
                        },
                        child: Text(
                          "register".tr,
                          style: GoogleFonts.montserrat(color: kTextPrimary, fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
