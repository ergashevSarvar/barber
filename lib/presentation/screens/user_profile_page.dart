import 'package:barber/presentation/widgets/profile_screen_tmp.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:barber/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/login/login_bloc.dart';
import '../widgets/easy_loading.dart';
import '../widgets/flashTabBar.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          context
              .read<LoginBloc>()
              .add(GetUserByIdRequest(state.userId, state.token));
        } else if (state is FetchUserLoading) {
          EasyLoading.show(status: "loading".tr);
        } else if (state is FetchUserSuccess) {
          EasyLoading.dismiss();
          return Scaffold(
            backgroundColor: kWhite,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: Container(
                            child: Image.asset(
                              "assets/images/back3.png",
                              width: double.infinity,
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.06,
                          left: MediaQuery.of(context).size.height * 0.01,
                          child: Icon(
                            Icons.menu,
                            size: 25,
                            color: kWhite,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              verticalSpace(60),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2, color: kWhite),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.asset(
                                    "assets/images/sarvar.jpg",
                                    width: 110,
                                  ),
                                ),
                              ),
                              verticalSpace(15),
                              Text(
                                "Sarvar Ergashev",
                                style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: kWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 95,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              color: kWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  // Shadow color
                                  spreadRadius: 5,
                                  // Spread radius
                                  blurRadius: 15,
                                  // Blur radius
                                  offset: Offset(0, 10), // Shadow offset
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 105,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Obunachilar".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "105",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: kBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(width: 0.5),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Likelar".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "1245",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: kBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(width: 0.5),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Izohlar".toUpperCase(),
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "872",
                                          style: GoogleFonts.montserrat(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: kBlue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ProfileScreenTmp(Icons.person_rounded, "Username",
                        state.userProfile.username),
                    ProfileScreenTmp(Icons.email, "Email",
                        state.userProfile.userEmail),
                    ProfileScreenTmp(Icons.person_rounded, "Ismi",
                        state.userProfile.firstname),
                    ProfileScreenTmp(Icons.person_rounded,
                        "Familiyasi", state.userProfile.lastname ?? ""),
                    ProfileScreenTmp(Icons.phone,
                        "Telegram telefon raqami", state.userProfile.telegramPhoneNumber ?? ""),
                    ProfileScreenTmp(Icons.person_pin,
                        "JSHSHIR", state.userProfile.pnfl ?? ""),
                    ProfileScreenTmp(Icons.location_on,
                        "Manzil", state.userProfile.address ?? ""),
                    ProfileScreenTmp(Icons.calendar_month,
                        "Tug'ilgan kun", state.userProfile.birthdate ?? ""),
                    ProfileScreenTmp(Icons.star,
                        "Maqom", state.userProfile.userRole ?? ""),
                    ProfileScreenTmp(Icons.mode_night_outlined,
                        "Tizim mavzusi", state.userProfile.appMode ?? ""),
                    // ProfileScreenTmp(Icons.person_rounded,
                    //     "gender", state.userProfile.gender ?? 0),
                    // ProfileScreenTmp(Icons.person_rounded,
                    //     "country", state.userProfile.country ?? 860),
                    // ProfileScreenTmp(Icons.person_rounded,
                    //     "region", state.userProfile.region ?? ""),
                    // ProfileScreenTmp(Icons.person_rounded,
                    //     "district", state.userProfile.district ?? ""),
                    // ProfileScreenTmp(Icons.person_rounded,
                    //     "status", state.userProfile.status ?? ""),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Flashtabbar(tabIndex: 4),
          );
        } else if (state is FetchUserFailure) {
          Get.snackbar(
            "warning".tr,
            state.error,
            isDismissible: true,
            duration: Duration(milliseconds: 2000),
            icon: Icon(Icons.warning_rounded, color: kTextDanger, size: 28),
            overlayBlur: 1,
          );
        }
        return Scaffold(
          body: Center(
            child: CustomEasyLoading(),
          ),
        );
      },
    );
  }
}
