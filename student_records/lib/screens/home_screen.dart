import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/model/db_function.dart';
import 'package:student_records/model/student_model.dart';
import 'package:student_records/screens/record_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final domainController = TextEditingController();

  final numberController = TextEditingController();

  final GlobalKey<FormState> _signInKey = GlobalKey();

  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9. !#$%&'*+-/ =? ^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final RegExp phoneValid = RegExp(r"^(?:\+91|91)?\s?[6-9]\d{9}$");

  final RegExp textValid = RegExp(r"^\s*[a-zA-Z,\s]+\s*$");

  File? _image;

  final picker = ImagePicker();

  String? _imagePath;

  Future getImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        _imagePath = _image!.path;
        print('Image Path: ${_image!.path}');
      } else {
        _image = File("asset/image/defaulProfileImage.jpg");
        _imagePath = _image!.path;
        print('Image Path: ${_image!.path}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // getAllStudent();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Form(
                    key: _signInKey,
                    child: Column(
                      children: [
                        const Text(
                          "Add student details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: _imagePath != null &&
                                          File(_imagePath!).existsSync()
                                      ? FileImage(File(_imagePath!))
                                      : const AssetImage(
                                              "asset/image/defaulProfileImage.jpg")
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () {
                                  getImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              } else if (!textValid.hasMatch(value)) {
                                return 'please folow text format';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(40, 10, 10, 10),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              } else if (!emailValid.hasMatch(value)) {
                                return 'please folow email format';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(40, 10, 10, 10),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: domainController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              } else if (!textValid.hasMatch(value)) {
                                return 'please folow text format';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your domain',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(40, 10, 10, 10),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(40),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: numberController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter a value';
                              } else if (!phoneValid.hasMatch(value)) {
                                return 'please folow number format';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(40, 10, 10, 10),
                                border: InputBorder.none),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 250,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50)),
                          margin: const EdgeInsets.all(20),
                          child: TextButton(
                            onPressed: () {
                              if (_signInKey.currentState!.validate()) {
                                debugPrint('form validated');
                                onSubmittCliked(context);
                              } else {
                                debugPrint("form not vlidated");
                              }
                            },
                            child: const Text(
                              "submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50)),
                  margin: const EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const RecordScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "Records",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmittCliked(BuildContext ctx) async {
    print('one submitte pressed');
    final name = nameController.text.trim();
    final emil = emailController.text.trim();
    final domain = domainController.text.trim();
    final number = numberController.text.trim();
    if (_imagePath != null) {
      final student = StudentModel(
          name: name,
          email: emil,
          domain: domain,
          number: number,
          image: _imagePath!);
      await addStudent(student);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) {
            return const RecordScreen();
          },
        ),
      );
      clearField();
      // getAllStudent();
    } else {
      showDialog(
          context: ctx,
          builder: (ctx1) {
            return AlertDialog(
              title: const Text('Please insert profile picture'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx1).pop();
                    },
                    child: const Text('close'))
              ],
            );
          });
    }
  }

  clearField() {
    nameController.clear();
    emailController.clear();
    domainController.clear();
    numberController.clear();
    setState(() {
      _imagePath = null;
    });
  }
}
