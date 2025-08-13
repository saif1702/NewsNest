import 'package:flutter/material.dart';
import 'package:newsnest/view/home.dart';
import 'package:newsnest/view/spalsh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showingSplash = true;
  LoadHome() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showingSplash = false;
      });
    });
  }

  @override
  initState() {
    super.initState();
    LoadHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      //for removeing debuf banner
      title: 'NewsNest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: showingSplash ? SpalshScreen() : HomeScreen(),
    );
  }
}
