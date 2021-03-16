import 'dart:async';

import 'package:hrms/data/sharedpref/constants/preferences.dart';
import 'package:hrms/routes.dart';
import 'package:flutter/material.dart';
import 'package:hrms/services/internetConnectivity.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _onBoardingMainState();
}

class _onBoardingMainState extends State<OnBoardingMain> {
  bool isOnline;
  List<Slide> slides = new List();
  final titleTextColor = Color(0xFF1C1A1A);
  final detailTextColor = Color(0xFF707070);
  final pageBGColor = Color(0xFFFFFFFF);
  final dotColor = Color(0xFF514ABF);
  final titleTextSize = 25.0;
  final detailTextSize = 15.0;
  final bottomBtnColor = Color(0xFF707070);
  final fontFamily = "Roboto";

  @override
  void initState() {
    super.initState();

    setState(() {
    });

    final titleTextStyle = TextStyle(
        color: titleTextColor,
        fontFamily: fontFamily,
        fontSize: titleTextSize,
        fontWeight: FontWeight.bold);

    final descriptionTextStyle = TextStyle(
        color: detailTextColor,
        fontFamily: fontFamily,
        fontSize: detailTextSize);

    // startTimer();
    slides.add(
      new Slide(
        title: "Easy task management",
        styleTitle: titleTextStyle,
        description:
            "Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.",
        styleDescription: descriptionTextStyle,
        pathImage: "assets/images/onBoarding_1.png",
        backgroundColor: pageBGColor,
      ),
    );
    slides.add(
      new Slide(
        title: "Work smarter",
        styleTitle: titleTextStyle,
        description:
            "Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring.",
        styleDescription: descriptionTextStyle,
        pathImage: "assets/images/onBoarding_2.png",
        backgroundColor: pageBGColor,
      ),
    );
    slides.add(
      new Slide(
        title: "Track your progress",
        styleTitle: titleTextStyle,
        description:
            "Capitalize on low hanging fruit to identify a ballpark value added activity to beta test. Override the digital divide with additional clickthroughs from DevOps. Nanotechnology immersion along the information highway will close the loop on focusing solely on the bottom line.",
        styleDescription: descriptionTextStyle,
        pathImage: "assets/images/onBoarding_3.png",
        backgroundColor: pageBGColor,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 40.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 300.0,
                height: 300.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 40.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {

    final bottomBtnStyle = TextStyle(color: detailTextColor, fontSize: 14.0);

    return Scaffold(
      backgroundColor: pageBGColor,
      body: new Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: new IntroSlider(
            slides: this.slides,
            listCustomTabs: this.renderListCustomTabs(),
            backgroundColorAllSlides: pageBGColor,
            onDonePress: this.navigate,
            colorActiveDot: dotColor,
            renderSkipBtn: FlatButton(
              child: Text(
                'Skip',
                style: bottomBtnStyle,
              ),
            ),
            renderNextBtn: FlatButton(
                child: Text(
              'Next',
              style: bottomBtnStyle,
            )),
            renderDoneBtn: FlatButton(
              child: Text(
                'Done',
                style: bottomBtnStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // startTimer() {
  //   var _duration = Duration(milliseconds: 3000);
  //   return Timer(_duration, navigate);
  // }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getBool(Preferences.is_logged_in) ?? false) {
      Navigator.of(context).pushReplacementNamed(Routes.dashboard);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
