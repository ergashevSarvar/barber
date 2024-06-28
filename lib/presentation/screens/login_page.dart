import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/widgets/divider.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';
import '../../utils/color.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          EasyLoading.show(status: "Yuklanmoqda");
        } else if (state is LoginSuccess) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, Routes.home);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Xush kelibsiz')),
          );
        } else if (state is LoginFailure) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
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
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Icon(Icons.lock, size: 126, color: darkGrey)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          "Tizimga xush kelibsiz!",
                          style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: textGrey,
                              fontWeight: FontWeight.w500),
                        ),
                        verticalSpace(15),
                        TextFormField(
                          initialValue: "men1",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Loginni kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) => _username = value!,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffE7E7E7),
                            labelText: "Loginni kiriting",
                            labelStyle: GoogleFonts.montserrat(color: textGrey),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(color: kWhite, width: 0.7)),
                          ),
                        ),
                        verticalSpace(15),
                        TextFormField(
                          initialValue: "1",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parolni kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value!,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffE7E7E7),
                            labelText: "Parolni kiriting",
                            labelStyle: GoogleFonts.montserrat(color: textGrey),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide:
                                    BorderSide(color: kWhite, width: 0.7)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Parolni unutdingizmi?",
                                  style: GoogleFonts.montserrat(
                                      color: textGrey,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          decoration: BoxDecoration(
                              color: darkGrey,
                              borderRadius: BorderRadius.circular(6)),
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
                              "Tizimga kirish".toUpperCase(),
                              style: GoogleFonts.montserrat(
                                  color: kWhite,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomDivider(
                      "Qo'shincha havolalar", textGrey, FontWeight.w400),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: lightGrey2,
                            border: Border.all(width: 1, color: kWhite),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        padding: EdgeInsets.all(12),
                        child:
                            Image.asset("assets/images/google.png", width: 60),
                        // child: Icon(Icons.add),
                      ),
                      horizontalSpace(30),
                      Container(
                        decoration: BoxDecoration(
                            color: lightGrey2,
                            border: Border.all(width: 1, color: kWhite),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/telegram.png",
                            width: 60),
                        // child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Yangimisiz? ",
                        style: GoogleFonts.montserrat(fontSize: 17),
                      ),
                      Text(
                        "Ro'yxatdan o'ting",
                        style: GoogleFonts.montserrat(
                            color: kTextPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
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
