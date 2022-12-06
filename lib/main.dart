import 'package:flutter/material.dart';
import 'package:water_monitoring_2/main_screen/mainScreen.dart';
import 'package:water_monitoring_2/defaultAssets.dart';
import 'package:water_monitoring_2/spash_screen/spashSreen.dart';

// Kode main

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Monitoring Air',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
