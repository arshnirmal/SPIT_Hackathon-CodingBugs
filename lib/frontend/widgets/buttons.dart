import 'package:flutter/material.dart';
import 'package:spit_hackathon/frontend/constants/colors_constants.dart';

class Buttons extends StatefulWidget {
  const Buttons({super.key});

  @override
  State<Buttons> createState() => _ButtonsState();
}

String message = "Something";
Widget _builderelevatedbutton() {
  return ElevatedButton(
    style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        maximumSize: MaterialStateProperty.all(const Size.fromWidth(100)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colorss.bordercolor))),
        alignment: Alignment.center,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(Colorss.buttonbg)),
    onLongPress: () {},
    onPressed: () {},
    child: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget _builderoutlinebutton() {
  return OutlinedButton(
    onPressed: () {},
    onLongPress: () {},
    style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        maximumSize: MaterialStateProperty.all(const Size.fromWidth(100)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colorss.bordercolor))),
        alignment: Alignment.center,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(Colorss.buttonbg)),
    child: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget _buildertextbutton() {
  return TextButton(
    onPressed: (() {}),
    onLongPress: () {},
    style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        maximumSize: MaterialStateProperty.all(const Size.fromWidth(100)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colorss.bordercolor))),
        alignment: Alignment.center,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(Colorss.buttonbg)),
    child: Text(
      message,
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget bbutton() {
  return IconButton(
    icon: const Icon(Icons.ac_unit),
    onPressed: (() {}),
    splashColor: Colorss.bordercolor,
    style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
        maximumSize: MaterialStateProperty.all(const Size.fromWidth(100)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colorss.bordercolor))),
        alignment: Alignment.center,
        enableFeedback: true,
        backgroundColor: MaterialStateProperty.all(Colorss.buttonbg)),
    color: Colorss.thirdcolor,
    splashRadius: 50,
  );
}

class _ButtonsState extends State<Buttons> {
  List<DropdownMenuItem<Object>> menuItems = [
    const DropdownMenuItem(value: "USA", child: Text("USA")),
    const DropdownMenuItem(value: "Canada", child: Text("Canada")),
    const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
    const DropdownMenuItem(value: "England", child: Text("England")),
  ];
  String selectedeleent = "USA";
  Widget _builddropdown() {
    return DropdownButton(
      borderRadius: BorderRadius.circular(30),
      dropdownColor: Colorss.bordercolor,
      // hint: Text("Country Name"),
      icon: const Icon(Icons.arrow_drop_down),
      value: selectedeleent,
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedeleent = value.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          _builderelevatedbutton(),
          const SizedBox(
            height: 5,
          ),
          _builderoutlinebutton(),
          const SizedBox(
            height: 5,
          ),
          _buildertextbutton(),
          const SizedBox(height: 5),
          _builddropdown(),
          const SizedBox(height: 5),
          bbutton(),
        ],
      ),
    );
  }
}
