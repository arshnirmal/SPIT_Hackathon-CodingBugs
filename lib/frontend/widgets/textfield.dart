import 'package:flutter/material.dart';
import '../constants/colors_constants.dart';

class Texttfields extends StatefulWidget {
  const Texttfields({super.key});

  @override
  State<Texttfields> createState() => _TexttfieldsState();
}

Widget textfield1(context) {
  return TextFormField(
    cursorColor: Colorss.cursorcolor,
    initialValue: 'Input text',
    maxLength: 20,
    decoration: const InputDecoration(
      icon: Icon(Icons.favorite),
      labelText: 'Label text',
      labelStyle: TextStyle(
        color: Color(0xFF6200EE),
      ),
      helperText: 'Helper text',
      suffixIcon: Icon(
        Icons.check_circle,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF6200EE)),
      ),
    ),
  );
}

class _TexttfieldsState extends State<Texttfields> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        textfield1(context),
      ]),
    );
  }
}

InputDecoration inputDecoration({
  String labelText = "",
  bool isObscure = true,
  Function? onSuffixPressed,
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Colorss.quaternrtyColor,
      fontSize: 18,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colorss.quaternrtyColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Colorss.quaternrtyColor,
      ),
    ),
    prefixIcon: labelText == "Name"
        ? const Icon(
            Icons.person,
            color: Colorss.quaternrtyColor,
          )
        : labelText == "E-mail"
            ? const Icon(
                Icons.email_sharp,
                color: Colorss.quaternrtyColor,
              )
            : labelText == "Password"
                ? const Icon(
                    Icons.lock,
                    color: Colorss.quaternrtyColor,
                  )
                : labelText == "Phone Number"
                    ? const Icon(
                        Icons.phone,
                        color: Colorss.quaternrtyColor,
                      )
                    : null,
    suffixIcon: labelText == "Password"
        ? IconButton(
            icon: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colorss.quaternrtyColor,
            ),
            onPressed: () {
              onSuffixPressed == null ? null : onSuffixPressed();
            },
          )
        : null,
  );
}
