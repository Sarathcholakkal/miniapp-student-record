import 'package:flutter/material.dart';
import 'package:student_records/screens/flash_screen.dart';
import 'package:student_records/model/db_function.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initilaizeDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const Flash_Screen(),
    );
  }
}
