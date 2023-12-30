import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/screens/resume_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResumeScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Text("Resume Builder", style: TextStyle(fontSize: 25,color:Colors.deepPurpleAccent.shade100,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic),),
                const Text("By Sumit Kumar",)
              ],
            ),
          )
      ),
    ) ;
  }
}
