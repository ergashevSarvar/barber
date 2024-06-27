import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/color.dart';

class CustomDivider extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  const CustomDivider(this.text, this.color, this.fontWeight);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 25.0, right: 10.0),
            child: Divider(
              thickness: 1,
            )),
      ),
      Text(
        text,
        style: GoogleFonts.montserrat(fontWeight: fontWeight, fontSize: 18, color: color),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 25.0),
            child: Divider(
              thickness: 1,
            )),
      ),
    ],);
  }
}