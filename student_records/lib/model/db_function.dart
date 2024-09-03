import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_records/model/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;
Future<void> initilaizeDataBase() async {
  _db = await openDatabase(
    'stunden_db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE studenttable (id INTEGER PRIMARY KEY, name TEXT,email TEXT,domain TEXT,phone TEXT,image TEXT)');
    },
  );
}

//==============add student=======================================
Future<void> addStudent(StudentModel studentdata) async {
  // print(studentdata.toString());  // studentListNotifier.value.add(studentdata);
  print(" check image direct${studentdata.image}");

  await _db.rawInsert(
      'INSERT INTO studenttable (name,email,domain,phone,image) VALUES (?,?,?,?,?)',
      [
        studentdata.name,
        studentdata.email,
        studentdata.domain,
        studentdata.number,
        studentdata.image,
      ]);
  await getAllStudent();
}
//============================== getAll student===========================

Future<void> getAllStudent() async {
  studentListNotifier.value.clear();
  final values = await _db.rawQuery('SELECT * FROM studenttable');
  values.forEach((map) {
    final student = StudentModel.formMap(map);
    studentListNotifier.value.add(student);
    studentListNotifier.notifyListeners();
  });

  print("$values this data map");
}

//===============delete student=====================
Future<void> deleteStudent(int id) async {
  print('id reciedved$id');
  await _db.rawDelete('DELETE FROM studenttable WHERE id=?', [id]);
  await getAllStudent();
}

//====================update student======================

Future<void> updateStudentData(
    {required String name,
    required String email,
    required String domain,
    required String number,
    required String image,
    required int id}) async {
  await _db.rawUpdate(
      'UPDATE studenttable SET name = ?, email = ?, domain = ?, phone = ?, image = ? WHERE id = ?',
      [name, email, domain, number, image, id]);
  await getAllStudent();
}
