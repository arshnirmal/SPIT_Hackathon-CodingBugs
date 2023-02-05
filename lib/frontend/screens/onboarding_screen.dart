import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/animation_constants.dart';
import 'package:spit_hackathon/frontend/constants/images_constants.dart';

import 'package:spit_hackathon/frontend/constants/mediaquery_contants.dart';
import 'package:spit_hackathon/main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late AnimationController animationController;
  Tween<Offset> hoverTween = Tween<Offset>(
      begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.03));
  int hoverDuration = 1000;
  int tabIndex = 0;

  //Change the images here
  List listOfScreens = [
    splashlogo,
    splashlogo,
    splashlogo,
  ];
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        initialIndex: 0,
        length: listOfScreens.length,
        vsync: this,
        animationDuration: const Duration(milliseconds: pageRouteDuration));

    tabController.addListener(() {
      setState(() {
        tabIndex = tabController.index;
      });
    });

    animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: hoverDuration),
        reverseDuration: Duration(milliseconds: hoverDuration));

    animationController.forward();
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: List.generate(
          listOfScreens.length,
          (index) => GestureDetector(
            onTap: ()async => index != listOfScreens.length - 1
                ? tabController.animateTo(tabIndex + 1,
                    curve: Curves.fastLinearToSlowEaseIn)
                : {
                    await sharedPreference.setBool('firstRun', false),
                    Navigator.pushReplacementNamed(context, '/wrapper'),
                  },
            child: SizedBox(
              height: MediaQueryConstants.getHeight(context),
              width: MediaQueryConstants.getWidth(context),
              child: SlideTransition(
                position: hoverTween.animate(
                  CurvedAnimation(
                    parent: animationController,
                    curve: hoverCurve,
                    reverseCurve: hoverCurve,
                  ),
                ),
                child: Image.asset(listOfScreens[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
