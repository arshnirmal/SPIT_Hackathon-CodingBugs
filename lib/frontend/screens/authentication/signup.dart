import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spit_hackathon/backend/services/firebase_services/controllers/signup_controller.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';
import 'package:spit_hackathon/frontend/constants/images_constants.dart';
import 'package:spit_hackathon/frontend/constants/texts_constants.dart';
import 'package:spit_hackathon/frontend/screens/authentication/login.dart';
import 'package:spit_hackathon/frontend/shared/toasts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isObscure = false;
  void onSuffixPressed() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  bool emailOk = false;
  bool passwordOk = false;
  bool phoneNoOk = false;
  bool nameOk = false;

  bool circularProgressBar = false;

  final controller = SignupController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorss.primaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            signUpHeader(),
            signUpForm(),
          ],
        ),
      ),
    );
  }

  Widget signUpHeader() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            signUpImage,
            fit: BoxFit.contain,
          ),
        ),
        const Text(
          signUpTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          signUpSubtitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget signUpForm() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            textFormFeild(
              false,
              "Name",
              onSuffixPressed,
              controller.fnameController,
              TextInputType.name,
            ),
            const SizedBox(
              height: 15,
            ),
            textFormFeild(
              false,
              "E-mail",
              onSuffixPressed,
              controller.emailController,
              TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 15,
            ),
            textFormFeild(
              isObscure,
              "Password",
              onSuffixPressed,
              controller.passwordController,
              TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 15,
            ),
            textFormFeild(
              false,
              "Phone Number",
              onSuffixPressed,
              controller.phoneNoController,
              TextInputType.phone,
            ),
            const SizedBox(
              height: 20,
            ),
            signUpButton(),
            const SizedBox(
              height: 10,
            ),
            // GoogleSignInButton(),
            const SizedBox(
              height: 10,
            ),
            otherMethod(),
          ],
        ),
      ),
    );
  }

  Widget textFormFeild(
    bool isObscure,
    String labelText,
    Function onSuffixPressed,
    TextEditingController controller,
    TextInputType keyboardType,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 64,
      child: TextFormField(
        obscureText: isObscure,
        decoration: inputDecoration(
          labelText: labelText.toString(),
          isObscure: isObscure,
          onSuffixPressed: onSuffixPressed,
        ),
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 16,
        ),
        inputFormatters: labelText == "Phone Number"
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ]
            : null,
        onChanged: (value) {
          if (labelText == "Name") {
            if (value.length > 3) {
              setState(
                () {
                  nameOk = true;
                },
              );
            } else {
              setState(
                () {
                  nameOk = false;
                },
              );
            }
          } else if (labelText == "E-mail") {
            if (EmailValidator.validate(value)) {
              setState(
                () {
                  emailOk = true;
                },
              );
            } else {
              setState(
                () {
                  emailOk = false;
                },
              );
            }
          } else if (labelText == "Password") {
            if (value.length > 8) {
              setState(
                () {
                  passwordOk = true;
                },
              );
            } else {
              setState(
                () {
                  passwordOk = false;
                },
              );
            }
          } else if (labelText == "Phone Number") {
            if (value.length == 10) {
              setState(
                () {
                  phoneNoOk = true;
                },
              );
            } else {
              setState(
                () {
                  phoneNoOk = false;
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget signUpButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 64,
      child: ElevatedButton(
        onPressed: !nameOk
            ? () {
                FlutterToast.showToast("Please enter a valid name", context);
              }
            : !emailOk
                ? () {
                    FlutterToast.showToast(
                        "Please enter a valid email", context);
                  }
                : !passwordOk
                    ? () {
                        FlutterToast.showToast(
                            "Please enter a password more than 8 character",
                            context);
                      }
                    : !phoneNoOk
                        ? () {
                            FlutterToast.showToast(
                                "Please enter a valid phone number", context);
                          }
                        : () async {
                            if (formKey.currentState!.validate()) {
                              setState(
                                () {
                                  circularProgressBar = true;
                                },
                              );
                              await controller.registerUser(
                                controller.emailController.text,
                                controller.passwordController.text,
                                context,
                              );
                              setState(
                                () {
                                  circularProgressBar = false;
                                },
                              );
                            }
                          },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colorss.quaternrtyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: circularProgressBar
            ? const CircularProgressIndicator(
                color: Colorss.teriaryColor,
              )
            : const Text(
                signUpButtonText,
                style: TextStyle(
                  fontSize: 18,
                  color: Colorss.teriaryColor,
                ),
              ),
      ),
    );
  }

  Widget otherMethod() {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: const TextStyle(
          color: Colorss.quaternrtyColor,
          fontSize: 18,
        ),
        children: [
          TextSpan(
            text: "Login!",
            style: const TextStyle(
              color: Color.fromARGB(255, 181, 105, 51),
              fontSize: 18,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
          ),
        ],
      ),
    );
  }
}
