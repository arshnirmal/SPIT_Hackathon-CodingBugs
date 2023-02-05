import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spit_hackathon/frontend/shared/toasts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _name = TextEditingController();
  final _phoneNo = TextEditingController();

  bool isNameOk = false;
  bool isPhoneOk = false;

  int _genid = 1;
  String profileURL = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height * 0.25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 72.0,
                    backgroundColor: Colors.amber,
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          ImagePicker profileImage = ImagePicker();
                          XFile? file = await profileImage.pickImage(
                            source: ImageSource.gallery,
                          );
                          print('${file?.path}');

                          if (file != null) return;
                          String uniqueFileName =
                              DateTime.now().millisecondsSinceEpoch.toString();
                          print(uniqueFileName);
                        },
                        child: const Icon(
                          Icons.person_add,
                          size: 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              textFormFeild("Name", _name),
              const SizedBox(
                height: 20,
              ),
              textFormFeild("Phone Number", _phoneNo),
              const SizedBox(
                height: 30,
              ),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFormFeild(String labelText, TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 64,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        keyboardType: labelText == "Phone Number"
            ? TextInputType.phone
            : TextInputType.name,
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
                  isNameOk = true;
                },
              );
            } else {
              setState(
                () {
                  isNameOk = false;
                },
              );
            }
          }
          if (labelText == "Phone Number") {
            if (value.length == 10) {
              setState(
                () {
                  isPhoneOk = true;
                },
              );
            } else {
              setState(
                () {
                  isPhoneOk = false;
                },
              );
            }
          }
        },
        controller: controller,
      ),
    );
  }

  Widget button() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3.5,
      height: 50,
      child: ElevatedButton(
        onPressed: !isNameOk
            ? () {
                FlutterToast.showToast(
                  "Please enter a valid name",
                  context,
                );
              }
            : !isPhoneOk
                ? () {
                    FlutterToast.showToast(
                      "Please enter a valid phone number",
                      context,
                    );
                  }
                : null,
        child: const Text(
          "Save",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Future createUser({
    required String name,
    required String phone,
    required int genid,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(name);
    String id = docUser.id;
    final user = User(
      id = docUser.id,
      name: name,
      phone: phone,
      genid: genid,
    );
    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  final int genid;
  String id;
  final String name;
  final String phone;
  User(
    String s, {
    this.id = '',
    required this.name,
    required this.phone,
    required this.genid,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
      };
}
