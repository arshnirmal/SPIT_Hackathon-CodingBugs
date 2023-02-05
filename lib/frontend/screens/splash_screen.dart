import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spit_hackathon/frontend/constants/animation_constants.dart';
import 'package:spit_hackathon/frontend/constants/images_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: splashScreenDuration),
        vsync: this);
    _sizeAnimation = Tween<double>(begin: 75, end: 150.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    animationController.forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        Navigator.pushReplacementNamed(context, '/wrapper');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _sizeAnimation,
          builder: (context, child) {
            return AnimatedContainer(
              duration: animationController.duration!,
              height: _sizeAnimation.value,
              width: _sizeAnimation.value,
              child: SvgPicture.asset(splashlogo),
            );
          },
        ),
      ),
    );
  }
}
