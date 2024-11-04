import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_records/model/db_function.dart';
import 'package:student_records/model/student_model.dart';
import 'package:student_records/screens/studnet_pages.dart';
import 'package:student_records/screens/update_screen.dart';

ValueNotifier<bool> isGridNotifier = ValueNotifier(true);

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  final searchController = TextEditingController();
  String? filter;
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Records"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                isGridNotifier.value = !isGridNotifier.value;
              },
              icon: ValueListenableBuilder(
                valueListenable: isGridNotifier,
                builder: (BuildContext ctx, bool boolValue, _) {
                  return boolValue
                      ? const Icon(Icons.view_list)
                      : const Icon(Icons.grid_on);
                },
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.zero,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: searchController,
                decoration: InputDecoration(
                    hintText: 'search items here.....',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    contentPadding: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: isGridNotifier,
                builder: (BuildContext ctx, bool boolValue, _) {
                  return ValueListenableBuilder(
                    valueListenable: studentListNotifier,
                    builder: (BuildContext ctx, List<StudentModel> newList, _) {
                      List<StudentModel> filterdList = [];
                      if (filter != null && filter!.isNotEmpty) {
                        filterdList = newList
                            .where((e) => e.name
                                .toLowerCase()
                                .contains(filter!.toLowerCase()))
                            .toList();
                      } else {
                        filterdList = newList;
                      }
                      return boolValue
                          ? GridView.builder(
                              itemCount: filterdList.length,
                              itemBuilder: (ctx, index) {
                                final student = filterdList[index];

                                return GestureDetector(
                                  onDoubleTap: () {
                                    Navigator.of(ctx).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentPage(student: student),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'aaa',
                                          style: TextStyle(),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: student.image != null
                                                      ? FileImage(
                                                          File(student.image))
                                                      : const AssetImage(
                                                              "asset/image/defaulProfileImage.jpg")
                                                          as ImageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          student.name,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          height: 50,
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  print('on pressed');

                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (ctx) {
                                                      return UpdateScreen(
                                                          studentData: student);
                                                    },
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  size: 30,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (student.id != null) {
                                                    deleteStudent(student.id!);
                                                  }
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              padding: const EdgeInsets.all(5),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                final student = newList[index];
                                return GestureDetector(
                                  onDoubleTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StudentPage(student: student),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: student.image != null
                                            ? FileImage(
                                                File(student.image),
                                              )
                                            : const AssetImage(
                                                    "asset/image/defaulProfileImage.jpg")
                                                as ImageProvider,
                                      ),
                                      title: Text(student.name),
                                      trailing: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize
                                            .min, //?  renderBox error will occure due to  unspeicifed size
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (ctx) {
                                                  return UpdateScreen(
                                                      studentData: student);
                                                },
                                              ));
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (student.id != null) {
                                                deleteStudent(student.id!);
                                              }
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: filterdList.length,
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
