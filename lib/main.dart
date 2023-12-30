import 'package:flutter/material.dart';
import 'package:resume_builder/screens/add_item_screen.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AddItemScreen(),
    );
  }
}


