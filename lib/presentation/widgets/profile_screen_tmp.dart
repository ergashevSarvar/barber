import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color.dart';

class ProfileScreenTmp extends StatelessWidget {
   IconData myIcon;
   String title = "";
   String content = "";

   ProfileScreenTmp(this.myIcon, this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          verticalSpace(20),
          Icon(myIcon, color: kGrey),
          horizontalSpace(12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: kGrey,
                  fontSize: 16,
                ),
              ),
              verticalSpace(3),
              Text(
                content,
                style: GoogleFonts.inter(
                  fontSize: 16,
                ),
              ),
              verticalSpace(15),
              Container(
                height: 0.7,
                width: MediaQuery.of(context).size.width!*0.76,
                decoration: BoxDecoration(color: kLightGrey),
              ),

            ],
          )
        ],
      ),
    );
  }
}
