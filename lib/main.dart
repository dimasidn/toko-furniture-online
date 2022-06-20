import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:toko_furniture_online/screen/checkout_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
          overscroll: false,
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          const CheckoutScreen(), //Ketik nama class dari screen lain di sini [ home: namaclass(), ]
    );
  }
}
