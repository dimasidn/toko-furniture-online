import 'package:flutter/material.dart';
import 'package:toko_furniture_online/screen/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Developing Project',
      theme: ThemeData(primaryColor: Colors.brown.shade200),
      home: const MyDashboard(),
    );
  }
}
