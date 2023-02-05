import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import 'package:spit_hackathon/backend/services/firebase_services/authentication_services.dart';
import 'package:spit_hackathon/frontend/shared/toasts.dart';

class SignupController {
  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNoController = TextEditingController();

  Future<User?> registerUser(
      String email, String password, BuildContext context) async {
    // String? error =
    //     AuthenticationRepository.instance.createUserWithEmailAndPassword(
    //   email,
    //   password,
    //   context,
    // ) as String?;
    // if (error != null) {
    //   FlutterToast.showToast(error, context);
    // }
    User? result = null;
    try {
      result = await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(
        email,
        password,
        context,
      );
    } catch (e) {
      FlutterToast.showToast(e.toString(), context);
    }
    return result;
  }
}
