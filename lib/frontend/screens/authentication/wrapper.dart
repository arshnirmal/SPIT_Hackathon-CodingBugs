import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spit_hackathon/backend/services/firebase_services/authentication_services.dart';
import 'package:spit_hackathon/frontend/screens/authentication/signup.dart';
import 'package:spit_hackathon/frontend/screens/navigation/fragments.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: AuthenticationRepository.instance.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Fragments();
          }
          return const SignupPage();
        });
  }
}
