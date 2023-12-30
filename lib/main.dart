import 'package:flutter/material.dart';
import 'package:resume_builder/screens/resume_screen.dart';
import 'package:resume_builder/splash_screen.dart';

void main() {
  runApp(const ResumeBuilder());
}

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Builder',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto'
      ),
      home: const SplashScreen(),
    );
  }
}


