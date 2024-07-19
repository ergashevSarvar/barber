import 'package:barber/presentation/blocs/register/register_bloc.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _password2 = '';
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _lang = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          EasyLoading.show(status: "loading".tr);
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
      child: Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: lightGrey,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    verticalSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () => Navigator.pushNamed(context, Routes.signinPage),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 22,
                            )),
                        Text(
                          "register2".tr.toUpperCase(),
                          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Container()
                      ],
                    ),
                    verticalSpace(30),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "loginErr1".tr;
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
                    ),
                    verticalSpace(25),
                    TextFormField(
                      onSaved: (value) => _email = value!,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE7E7E7),
                        labelText: "enterEmail".tr,
                        labelStyle: GoogleFonts.montserrat(color: textGrey),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE7E7E7),
                        labelText: "enterPassword".tr,
                        labelStyle: GoogleFonts.montserrat(color: textGrey),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE7E7E7),
                        labelText: "enterPassword2".tr,
                        labelStyle: GoogleFonts.montserrat(color: textGrey),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE7E7E7),
                        labelText: "enterFirstname".tr,
                        labelStyle: GoogleFonts.montserrat(color: textGrey),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xffE7E7E7),
                        labelText: "enterLastname".tr,
                        labelStyle: GoogleFonts.montserrat(color: textGrey),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(6)), borderSide: BorderSide(color: kWhite, width: 0.7)),
                      ),
                    ),
                    verticalSpace(25),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(color: darkGrey, borderRadius: BorderRadius.circular(6)),
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            BlocProvider.of<RegisterBloc>(context).add(
                              RegisterRequest(_username, _email, _password, _firstName, _lastName),
                            );
                          }
                        },
                        child: Text(
                          "register2".tr.toUpperCase(),
                          style: GoogleFonts.montserrat(color: kWhite, fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
