import 'package:flutter/material.dart';
import 'package:resume_builder/screens/resume_screen.dart';

void main() {
  runApp(const ResumeBuilder());
}

class ResumeBuilder extends StatelessWidget {
  const ResumeBuilder({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          hintColor: Colors.orange,
          fontFamily: 'Roboto'
      ),
      home: ResumeScreen(),
    );
  }
}


