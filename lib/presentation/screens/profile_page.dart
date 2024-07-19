import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:barber/presentation/blocs/logout/logout_bloc.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../routes.dart';
import '../blocs/login/login_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          EasyLoading.show(
              status: "loading".tr,
              indicator: LoadingAnimationWidget.threeArchedCircle(
                color: textYellow,
                size: 70,
              ));
        } else if (state is LogoutSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, Routes.signinType);
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset(
                        "assets/images/sarvar.jpg",
                        width: 70,
                      ),
                    ),
                    horizontalSpace(17),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sarvar Ergashev",
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kDarkBlue,
                          ),
                        ),
                        Text(
                          "sarvarergashev776@gmail.com",
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kDarkBlue,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Text("personalInfo".tr, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/User_alt_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("persoalData".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Wallet_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("payment".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/security.svg", width: 26),
                          horizontalSpace(10),
                          Text("security".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Text("general".tr, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.changeLangPage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/language.svg", width: 26),
                          horizontalSpace(10),
                          Text("language".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Bell_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("notification".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Trash_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("cache".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text("88 mb", style: GoogleFonts.montserrat(fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff666D80))),
                    ],
                  ),
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Text("about".tr, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Question_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("helpCenter".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/Lock_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("privacyPolicy".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/info_light.svg", width: 30),
                          horizontalSpace(10),
                          Text("aboutApp".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    // new page here
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          horizontalSpace(3),
                          SvgPicture.asset("assets/svg/terms.svg", width: 30),
                          horizontalSpace(10),
                          Text("termCondition".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios, color: Color(0xff666D80), size: 20)
                    ],
                  ),
                ),
                verticalSpace(17),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: kWhite,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                        builder: (context) {
                          return SizedBox(
                            width: double.infinity,
                            height: 270,
                            child: Column(
                              children: [
                                verticalSpace(14),
                                Container(
                                  width: 80,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                verticalSpace(35),
                                Text(
                                  "signOut".tr,
                                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: kTextDanger2),
                                ),
                                verticalSpace(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(),
                                ),
                                verticalSpace(10),
                                Text(
                                  "confirmSignOut".tr,
                                  style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600),
                                ),
                                verticalSpace(30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        EasyLoading.dismiss();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(color: kWhite, borderRadius: BorderRadius.circular(40), border: Border.all(width: 1, color: kTextDanger2)),
                                        child: Text(
                                          "cancel".tr,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(color: kTextDanger2, fontWeight: FontWeight.w600, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    horizontalSpace(35),
                                    BlocBuilder<LoginBloc, LoginState>(
                                      builder: (context, state) {
                                        if (state is LoginSuccess) {
                                          return GestureDetector(
                                            onTap: () {
                                              context.read<LogoutBloc>().add(LogOutRequest(state.token));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                              decoration: BoxDecoration(color: kTextDanger2, borderRadius: BorderRadius.circular(40)),
                                              child: Text(
                                                "accept".tr,
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.montserrat(color: kWhite, fontWeight: FontWeight.w600, fontSize: 18),
                                              ),
                                            ),
                                          );
                                        }
                                        return Container();
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      horizontalSpace(3),
                      SvgPicture.asset("assets/svg/Sign_in_circle_light.svg", width: 30, color: kTextDanger),
                      horizontalSpace(10),
                      Text("signOut".tr, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w500, color: kTextDanger)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
