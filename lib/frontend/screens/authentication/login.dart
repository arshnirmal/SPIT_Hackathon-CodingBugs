import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:spit_hackathon/frontend/screens/authentication/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isObscure = true;
  String _email = "";
  final String _password = "";
  bool _emailOk = false;
  bool circularProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 22, 57),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image(
                  image: const AssetImage("assets/images/landingPage3.png"),
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.47,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        textFormField("Email Address", false),
                        const SizedBox(
                          height: 10,
                        ),
                        textFormField("Password", _isObscure),
                        const SizedBox(
                          height: 24,
                        ),
                        button(),
                        const SizedBox(
                          height: 24,
                        ),
                        // const Text(
                        //   "-----------------OR-----------------",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        socialLogin(),
                        const SizedBox(
                          height: 10,
                        ),
                        otherMethod(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFormField(String label, bool isObscure) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 64,
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          suffixIcon: label == "Password"
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _isObscure = !_isObscure;
                      },
                    );
                  },
                )
              : null,
        ),
        style: const TextStyle(
          fontSize: 16,
        ),
        onChanged: (val) {
          if (label == "Email Address") {
            setState(
              () {
                _email = val;
                _emailOk = EmailValidator.validate(_email);
              },
            );
          }
        },
      ),
    );
  }

  Widget button() {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.5,
        height: 50,
        child: ElevatedButton(
          onPressed: _emailOk
              ? () {
                  setState(
                    () {
                      circularProgressBar = true;
                    },
                  );
                  try {
                    _auth.signInWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                    Navigator.pushReplacementNamed(context, "/home");
                  } on FirebaseAuthException catch (e) {
                    SnackBar snackBar = SnackBar(
                      content: Text(
                        e.message!,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 76, 0),
            padding: const EdgeInsets.all(4.0),
            shape: const StadiumBorder(),
          ),
          child: const Text(
            "Log in",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget socialLogin() {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/images/google.png"),
            ),
            iconSize: 50,
          ),
          const SizedBox(
            width: 60,
          ),
          IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/images/facebook.png"),
            ),
            iconSize: 50,
          ),
          const SizedBox(
            width: 60,
          ),
          IconButton(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/images/twitter.png"),
            ),
            iconSize: 50,
          ),
        ],
      ),
    );
  }

  Widget otherMethod() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          const TextSpan(
            text: "Don't have an account? ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 76, 0),
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
