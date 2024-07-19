import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes.dart';
import '../../utils/color.dart';
import '../blocs/register/register_bloc.dart';
import '../widgets/divider.dart';
import '../widgets/verticalHorizontalSpace.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({super.key});

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _password2 = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _lang = '';

  List<FocusNode> _focusNodes = List.generate(10, (index) => FocusNode());
  List<bool> _isFocused = List.generate(10, (index) => false);

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
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            EasyLoading.show(
                status: "loading".tr,
                indicator: LoadingAnimationWidget.threeArchedCircle(
                  color: textYellow,
                  size: 70,
                ));
          } else if (state is RegisterSuccess) {
            EasyLoading.dismiss();
            Navigator.pushNamed(context, Routes.signinPage);
            Get.snackbar(
              "successful".tr,
              state.message,
              isDismissible: true,
              duration: Duration(milliseconds: 1500),
              icon: Icon(Icons.check_circle, color: kTextSuccess, size: 28),
              overlayBlur: 0,
            );
          } else if (state is RegisterFailure) {
            EasyLoading.dismiss();
            Get.snackbar(
              "warning".tr,
              state.error,
              isDismissible: true,
              duration: Duration(milliseconds: 3000),
              icon: Icon(Icons.warning_rounded, color: kTextDanger, size: 28),
              overlayBlur: 1,
            );
          }
        },
        child: Scaffold(
          backgroundColor: kWhite,
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "register".tr,
                            style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          horizontalSpace(5),
                          Icon(Icons.edit_outlined)
                        ],
                      ),
                      verticalSpace(10),
                      Text("registerL".tr, textAlign: TextAlign.left, style: GoogleFonts.montserrat(fontSize: 18))
                    ],
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          verticalSpace(35),
                          TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "loginErr1".tr;
                              }
                              return null;
                            },
                            onSaved: (value) => _username = value!,
                            focusNode: _focusNodes[1],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[1] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterLogin".tr,
                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          verticalSpace(25),
                          TextFormField(
                            onSaved: (value) => _email = value!,
                            focusNode: _focusNodes[2],
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@.\-_]')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'Email manzil formati xato kiritilgan';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[2] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterEmail".tr,

                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),

                            ),
                          ),
                          verticalSpace(25),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "passwordErr1".tr;
                              }
                              return null;
                            },
                            obscureText: true,
                            onSaved: (value) => _password = value!,
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            focusNode: _focusNodes[3],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[3] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterPassword".tr,
                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          verticalSpace(25),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "passwordErr1".tr;
                              } else if (_password != value) {
                                return "passwordDontMatch".tr;
                              }
                              return null;
                            },
                            obscureText: true,
                            onSaved: (value) => _password2 = value!,
                            onChanged: (value) {
                              setState(() {
                                _password2 = value;
                              });
                            },
                            focusNode: _focusNodes[4],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[4] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterPassword2".tr,
                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          verticalSpace(25),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "firstNameErr1".tr;
                              }
                              return null;
                            },
                            onSaved: (value) => _firstName = value!,
                            focusNode: _focusNodes[5],
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[5] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterFirstname".tr,
                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          verticalSpace(25),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "lastNameErr1".tr;
                              }
                              return null;
                            },
                            onSaved: (value) => _lastName = value!,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                            ],
                            focusNode: _focusNodes[6],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: _isFocused[6] ? textYellowLight : Colors.white,
                              errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                              hintText: "enterLastname".tr,
                              hintStyle: GoogleFonts.montserrat(),
                              labelStyle: GoogleFonts.montserrat(color: textGrey),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      verticalSpace(35),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<RegisterBloc>(context).add(
                                RegisterRequest(_username, _email, _password, _firstName, _lastName),
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
                              "register2".tr,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(color: kWhite, fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(30),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "hasAccount".tr + " ",
                          style: GoogleFonts.montserrat(fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.signinType);
                          },
                          child: Text(
                            "enterSystem".tr,
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
