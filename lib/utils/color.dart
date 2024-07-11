import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


const Color kWhite = Color(0xffffffff);
const Color kLightWhite = Color(0xffeff5f4);
const Color kLighterWhite = Color(0xfffcfcfc);
const Color kGrey = Color(0xff9397a0);
const Color kLightGrey = Color(0xffa7a7a7);
const Color kBlue = Color(0xff5474fd);
const Color kLightBlue = Color(0xff83b1ff);
const Color kLighterBlue = Color(0xffc1d4f9);
const Color kDarkBlue = Color(0xff19202d);
const Color kBorderColor = Color(0xffEEEEEE);
const Color kTextPrimary = Color(0xff007bff);
const Color kTextPrimaryDark = Color(0xff0253b4);
const Color kTextSuccess = Color(0xff28a745);
const Color kTextWarning = Color(0xffffc107);
const Color kTextInfo = Color(0xff17a2b8);
const Color kTextDanger = Color(0xffdc3545);
const Color kTextWarning2 = Color(0xffd78c05);
const Color kTextSecondary = Color(0xffadb7be);
const Color kTextGreen = Color(0xff357c1c);
const Color kTextGreen2 = Color(0xff279687);
const Color color2022 = Color(0xff6463b1);
const Color color2020 = Color(0xff0f4a81);
const Color color2018 = Color(0xff714694);
const Color colorMy = Color(0xff018bd5);
const Color lightGrey = Color(0xffD8D8D8);
const Color lightGrey2 = Color(0xffeaeaea);
const Color darkGrey = Color(0xff1D1D1D);
const Color textGrey = Color(0xff676767);
const Color textYellow = Color(0xffFFB901);
const onBoardingColor = Color(0xFF7357a4);

numberFormat(number) {
  if (number == null || number == "0" || number == "0.0" || number == "0.00") {
    return "0.00";
  }
  var formatter = NumberFormat('#,###.00');
  double db = double.parse(number);
  return formatter.format(db).toString().replaceAll(",", " ");
}

const double kBorderRaius = 16.0;

final kBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(kBorderRaius), borderSide: BorderSide.none);

final kPoppinsBold = TextStyle(color: kDarkBlue, fontWeight: FontWeight.w700, fontFamily: "Poppins");

final kPoppinsSemiBold = TextStyle(color: kDarkBlue, fontWeight: FontWeight.w600, fontFamily: "Poppins");

final kPoppinsMedium = TextStyle(color: kDarkBlue, fontWeight: FontWeight.w500, fontFamily: "Poppins");

final kPoppinsRegular = TextStyle(color: kDarkBlue, fontWeight: FontWeight.w400, fontFamily: "Poppins");