import 'package:flutter/material.dart';
import 'package:student_records/model/db_function.dart';
import 'package:student_records/model/student_model.dart';

class UpdateScreen extends StatefulWidget {
  final StudentModel studentData;

  const UpdateScreen({super.key, required this.studentData});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController domainController;
  late TextEditingController numberController;
  late String imagePath;
  late int id;
  @override
  void initState() {
    nameController = TextEditingController(text: widget.studentData.name);
    emailController = TextEditingController(text: widget.studentData.email);
    domainController = TextEditingController(text: widget.studentData.domain);
    numberController = TextEditingController(text: widget.studentData.number);
    imagePath = widget.studentData.image;
    id = widget.studentData.id!;

    super.initState();
  }

  final GlobalKey<FormState> _signInKey = GlobalKey();

  final RegExp emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9. !#$%&'*+-/ =? ^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final RegExp phoneValid = RegExp(r"^(?:\+91|91)?\s?[6-9]\d{9}$");

  final RegExp textValid = RegExp(r"^\s*[a-zA-Z,\s]+\s*$");

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
                          "Update student details",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
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
                          margin: const EdgeInsets.only(left: 50),
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
    final email = emailController.text.trim();
    final domain = domainController.text.trim();
    final number = numberController.text.trim();

    updateStudentData(
        name: name,
        email: email,
        domain: domain,
        number: number,
        image: imagePath,
        id: id);
    Navigator.of(context).pop();
  }
}
