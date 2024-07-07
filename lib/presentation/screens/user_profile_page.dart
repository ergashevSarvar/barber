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
          context.read<LoginBloc>().add(GetUserByIdRequest(state.userId, state.token));
        } else if (state is FetchUserLoading) {
          EasyLoading.show(status: "loading".tr);
        } else if (state is FetchUserSuccess) {
          EasyLoading.dismiss();
          return Scaffold(
            backgroundColor: lightGrey,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                          child: Container(
                            child: Image.asset("assets/images/back3.png", width: double.infinity, height: 350, fit: BoxFit.cover),
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
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              verticalSpace(60),
                              Container(
                                decoration: BoxDecoration(border: Border.all(width: 2, color: kWhite), borderRadius: BorderRadius.all(Radius.circular(80))),
                                child: ClipRRect(
                                  child: Image.asset(
                                    "assets/images/sarvar.jpg",
                                    width: 110,
                                  ),
                                  borderRadius: BorderRadius.circular(80),
                                ),
                              ),
                              verticalSpace(15),
                              Text(
                                state,
                                style: GoogleFonts.montserrat(fontSize: 25, fontWeight: FontWeight.w600, color: kWhite),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.29,
                          left: MediaQuery.of(context).size.width * 0.075,
                          child: Container(
                            height: 95,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(color: kWhite, borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 105,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Obunachilar".toUpperCase(),
                                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "105",
                                          style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600, color: kBlue),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.5))),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Likelar".toUpperCase(),
                                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "1245",
                                          style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600, color: kBlue),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(border: Border(right: BorderSide(width: 0.5))),
                                  ),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                          "Izohlar".toUpperCase(),
                                          style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "872",
                                          style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600, color: kBlue),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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
