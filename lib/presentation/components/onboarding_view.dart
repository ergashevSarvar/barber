import 'package:barber/presentation/screens/login_page.dart';
import 'package:barber/presentation/widgets/verticalHorizontalSpace.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/color.dart';
import 'onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Color(0xffFCF8FF),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Skip Button
            TextButton(
                onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                child: Text("O'tkazish", style: GoogleFonts.montserrat(color: darkGrey, fontWeight: FontWeight.w600))),

            //Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index)=> pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: textYellow,
                dotColor: lightGrey
              ),
            ),

            //Next Button
            TextButton(
                onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child: Text("Keyingi", style: GoogleFonts.montserrat(color: darkGrey, fontWeight: FontWeight.w600))),


          ],
        ),
      ),
      body: PageView.builder(
          onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(controller.items[index].image),
                verticalSpace(15),
                Text(controller.items[index].title,
                  style: GoogleFonts.montserrat(fontSize: 26,fontWeight: FontWeight.bold, ),textAlign: TextAlign.center,),
                verticalSpace(5),
                Text(controller.items[index].descriptions,
                    style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 15), textAlign: TextAlign.center),
              ],
            );

          }),
    );
  }

  //Get started button

  Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: textYellow
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            //After we press get started button this onboarding value become true
            // same key
            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },
          child:  Text("Boshladik",style: GoogleFonts.montserrat(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18),)),
    );
  }
}