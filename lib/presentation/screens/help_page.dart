import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes.dart';
import '../../utils/color.dart';
import '../controller/page_controller.dart';
import '../widgets/verticalHorizontalSpace.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  GetxPageController getxPageController = Get.find();

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
                    "helpCenter".tr,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  horizontalSpace(18),
                ],
              ),
              verticalSpace(30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0, left: 8),
                      child: Icon(Icons.tune, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              verticalSpace(25),
              Text(
                "Ko'p beriladigan savollar",
                style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600, color: textGrey),
              ),
              verticalSpace(20),
              ExpansionTile(
                title: Text(
                  '• Qanday qilib ro\'yxatdan o\'tiladi',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  '• Maqom qanday o\'zgartiriladi?',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  '• To\'lov qanday qilinadi?',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  '• Lorem ipsum dolor sit amet',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  '• Lorem ipsum dolor sit amet',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      ' Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  '• Lorem ipsum dolor sit amet',
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
                    child: Text(
                      'Turpis lectus egestas dui proin natoque nulla egestas fames molestie. Euismod orci nisl enim pharetra lectus morbi massa nibh non.',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.montserrat(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
