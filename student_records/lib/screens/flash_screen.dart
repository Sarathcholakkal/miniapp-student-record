import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_records/model/db_function.dart';
import 'package:student_records/screens/home_screen.dart';

class Flash_Screen extends StatefulWidget {
  const Flash_Screen({super.key});

  @override
  State<Flash_Screen> createState() => _Flash_ScreenState();
}

class _Flash_ScreenState extends State<Flash_Screen> {
  @override
  void initState() {
    callDelaty();
    getAllStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Lottie.network(
              'https://lottie.host/677f56bc-4932-44bc-8998-b69c792496ad/IzWFPneGD7.json'),
        ),
      ),
    );
  }

  callDelaty() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return const HomeScreen();
          //  HomeScreen();
        },
      ),
    );
  }
}
