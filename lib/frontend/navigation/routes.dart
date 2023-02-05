import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/animation_constants.dart';
import 'package:spit_hackathon/frontend/screens/authentication/login.dart';
import 'package:spit_hackathon/frontend/screens/authentication/signup.dart';
import 'package:spit_hackathon/frontend/screens/authentication/wrapper.dart';
import 'package:spit_hackathon/frontend/screens/marketplace.dart/redeem.dart';
import 'package:spit_hackathon/frontend/screens/posts/create_posts.dart';
import 'package:spit_hackathon/frontend/screens/maps/maps_screen.dart';
import 'package:spit_hackathon/frontend/screens/navigation/fragments.dart';
import 'package:spit_hackathon/frontend/screens/profile/edit_profile_screen.dart';

class AppRoutes {
  static Route? generatedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return pageRoutes(child: const Wrapper());
      case '/authentication':
        return pageRoutes(child: const SignupPage());
      case '/login':
        return pageRoutes(child: const LoginPage());
      case '/wrapper':
        return pageRoutes(child: const Wrapper());
      case '/fragments':
        return pageRoutes(child: const Fragments());
      case '/signup':
        return pageRoutes(child: const SignupPage());
      case '/maps':
        return pageRoutes(child: const MapsScreen());
      case '/editProfile':
        return pageRoutes(child: const EditProfile());
      case '/createPost':
        return pageRoutes(child: const CreatePost());
      case '/posts':
        return pageRoutes(child: const CreatePost());
      case '/redeem' : 
      return pageRoutes(child: const Redeem());
      default:
        return errorRoute();
    }
  }

  static Route errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }

  static PageRouteBuilder pageRoutes({required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        Tween<Offset> pageOffsetTween = Tween<Offset>(
            begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0));
        Curve pageCurve = Curves.fastLinearToSlowEaseIn;

        return SlideTransition(
            position: pageOffsetTween
                .chain(CurveTween(curve: pageCurve))
                .animate(animation),
            child: child);
      },
      transitionDuration: const Duration(milliseconds: pageRouteDuration),
      reverseTransitionDuration:
          const Duration(milliseconds: pageRouteDuration),
    );
  }
}
