import 'package:flutter/material.dart';
import 'package:friend/pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize hive for local slorage
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
