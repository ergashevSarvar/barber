import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/register/register_bloc.dart';
import '../widgets/divider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _showHidePassword = true;

  void showHidePassword() {
    setState(() {
      _showHidePassword = !_showHidePassword;
    });
  }

  List<FocusNode> _focusNodes = List.generate(2, (index) => FocusNode());
  List<bool> _isFocused = List.generate(2, (index) => false);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          _isFocused[i] = _focusNodes[i].hasFocus;
        });
      });
    }
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            EasyLoading.show(
                status: "loading".tr,
                indicator: LoadingAnimationWidget.threeArchedCircle(
                  color: textYellow,
                  size: 70,
                ));
          } else if (state is LoginSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamed(context, Routes.homePageRouter);
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                "successful".tr,
                state.message,
                isDismissible: true,
                duration: Duration(milliseconds: 1500),
                icon: Icon(Icons.check_circle, color: kTextSuccess, size: 28),
                overlayBlur: 0,
              );
            }
          } else if (state is LoginFailure) {
            EasyLoading.dismiss();
            if (!Get.isSnackbarOpen) {
              Get.snackbar(
                "warning".tr,
                state.error,
                isDismissible: true,
                duration: Duration(milliseconds: 2000),
                icon: Icon(Icons.warning_rounded, color: kTextDanger, size: 28),
                overlayBlur: 1,
              );
            }
          }
        },
        child: Scaffold(
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "welcome".tr,
                            style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          horizontalSpace(5),
                          Text(
                            "👋",
                            style: TextStyle(fontSize: 22),
                          )
                        ],
                      ),
                      verticalSpace(10),
                      Text("signInPassword".tr, textAlign: TextAlign.left, style: GoogleFonts.montserrat(fontSize: 18))
                    ],
                  ),
                  verticalSpace(50),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'login'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                                  ],
                                  focusNode: _focusNodes[0],
                                  initialValue: state is RegisterSuccess ? "${state.username}" : "",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "enterLogin".tr;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _username = value!,
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    filled: true,
                                    fillColor: _isFocused[0] ? textYellowLight : Colors.white,
                                    hintText: "enterLogin".tr,
                                    hintStyle: GoogleFonts.montserrat(),
                                    labelStyle: GoogleFonts.montserrat(color: textGrey),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        verticalSpace(15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'password'.tr,
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            verticalSpace(8),
                            TextFormField(
                              focusNode: _focusNodes[1],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "enterPassword".tr;
                                }
                                return null;
                              },
                              onSaved: (value) => _password = value!,
                              obscureText: _showHidePassword,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: _isFocused[1] ? textYellowLight : Colors.white,
                                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      showHidePassword();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 22),
                                      child: Image.asset("assets/icons/${_showHidePassword ? 'eye_open.png' : 'eye_close.png'}", width: 15, height: 15,),
                                    )),
                                suffixIconColor: textGrey,
                                hintText: "enterPassword".tr,
                                hintStyle: GoogleFonts.montserrat(),
                                labelStyle: GoogleFonts.montserrat(color: textGrey),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("Forget Password");
                                },
                                child: Text(
                                  "forgetPassword".tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16, color: textYellow2),
                                  textAlign: TextAlign.right,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  verticalSpace(50),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<LoginBloc>(context).add(
                                LoginRequested(_username, _password),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              backgroundColor: textYellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "signin".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(color: kWhite, fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      CustomDivider("or".tr, textGrey, FontWeight.w400),
                      verticalSpace(20),
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
                      verticalSpace(20),
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
                    ],
                  ),
                  verticalSpace(80),
                  Container(
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
          ),
        ),
      ),
    );
  }
}
