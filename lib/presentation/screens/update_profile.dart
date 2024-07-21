import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:barber/presentation/blocs/login/login_bloc.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/color.dart';
import '../widgets/easy_loading.dart';
import '../widgets/verticalHorizontalSpace.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _password2 = '';
  String _email = '';
  String _phoneNumber = '';
  String _birthday = '';
  String _firstName = '';
  String _lastName = '';

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
        child: Scaffold(
      backgroundColor: kWhite,
      body: SingleChildScrollView(
        child: Container(
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
                    "personalInfo".tr,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  horizontalSpace(18),
                ],
              ),
              verticalSpace(10),
              Stack(children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.asset(
                      "assets/images/sarvar.jpg",
                      width: 100,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: textYellow, borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Icon(
                      Icons.edit_outlined,
                      color: kWhite,
                      size: 15,
                    ),
                  ),
                )
              ]),
              verticalSpace(20),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginSuccess) {
                    context.read<LoginBloc>().add(GetUserByIdRequest(state.userId, state.token));
                  } else if (state is FetchUserLoading) {
                    EasyLoading.show(
                        status: "loading".tr,
                        indicator: LoadingAnimationWidget.threeArchedCircle(
                          color: textYellow,
                          size: 70,
                        ));
                  } else if (state is FetchUserSuccess) {
                    EasyLoading.dismiss();
                    return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'firstName'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "firstNameErr1".tr;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _firstName = value!,
                                  focusNode: _focusNodes[1],
                                  initialValue: state.userProfile.firstname,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: _isFocused[1] ? textYellowLight : Colors.white,
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    hintText: "enterFirstname".tr,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'lastName'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  initialValue: state.userProfile.lastname,
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
                                  focusNode: _focusNodes[2],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: _isFocused[2] ? textYellowLight : Colors.white,
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
                            ),
                            verticalSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'login'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  initialValue: state.userProfile.username,
                                  readOnly: true,
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
                                  focusNode: _focusNodes[3],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: _isFocused[3] ? textYellowLight : Colors.white,
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    hintText: "enterLogin".tr,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'email'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  initialValue: state.userProfile.email,
                                  readOnly: true,
                                  onSaved: (value) => _email = value!,
                                  focusNode: _focusNodes[4],
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
                                    fillColor: _isFocused[4] ? textYellowLight : Colors.white,
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    hintText: "enterEmail".tr,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'phoneNumber'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  initialValue: "${state.userProfile.phone[0]}",
                                  onSaved: (value) => _phoneNumber = value!,
                                  focusNode: _focusNodes[5],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (value) {
                                    if (value == null) {
                                      return "phoneNumberErr1".tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: _isFocused[5] ? textYellowLight : Colors.white,
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    prefix: Text("+"),
                                    hintText: "phoneNumber".tr,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'birthday'.tr,
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                verticalSpace(8),
                                TextFormField(
                                  initialValue: _birthday.isEmpty ?  "${DateFormat('dd.MM.yyyy').format(DateTime.parse(state.userProfile.birthdate))}" : _birthday,
                                  readOnly: true,
                                  onSaved: (value) => _birthday = value!,
                                  focusNode: _focusNodes[6],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (value) {
                                    if (value == null) {
                                      return "birthdayErr1".tr;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: _isFocused[6] ? textYellowLight : Colors.white,
                                    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                    hintText: "enterBirthday".tr,
                                    hintStyle: GoogleFonts.montserrat(),
                                    labelStyle: GoogleFonts.montserrat(color: textGrey),
                                    suffixIcon: GestureDetector(child: Icon(Icons.date_range, color: textGrey, size: 26), onTap: () => _openDatePicker(context)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: lightGrey)),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textYellow), borderRadius: BorderRadius.circular(12)),
                                    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: kTextDanger), borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                  }
                  return Center(
                    child: CustomEasyLoading(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      pickerTitle: Text(
        'enterBirthday'.tr,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime(1996, 10, 22),
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1900),
      pickerTextStyle: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      onSubmit: (index) {
        print(index.runtimeType);
        setState(() {
          _birthday = "${DateFormat('dd.MM.yyyy').format(index)}";
        });
        print(_birthday);
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

}
