import 'package:flutter/material.dart';
import 'package:newsnest/view/home.dart';
import 'package:newsnest/view/notification.dart';
import 'package:newsnest/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase and Notifications first
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showingSplash = true;

  void loadHome() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showingSplash = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: showingSplash
          ? const SplashScreen()
          : const HomeScreen(), // Shows splash first, then home
    );
  }
}
