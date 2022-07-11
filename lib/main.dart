import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../conf/route.dart';
import '../screen/login_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
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
      title: 'Toko Furniture Online',
      theme: ThemeData(
          primarySwatch: const MaterialColor(0xFFFF4081, {
        50: Color.fromRGBO(255, 64, 129, .1),
        100: Color.fromRGBO(255, 64, 129, .2),
        200: Color.fromRGBO(255, 64, 129, .3),
        300: Color.fromRGBO(255, 64, 129, .4),
        400: Color.fromRGBO(255, 64, 129, .5),
        500: Color.fromRGBO(255, 64, 129, .6),
        600: Color.fromRGBO(255, 64, 129, .7),
        700: Color.fromRGBO(255, 64, 129, .8),
        800: Color.fromRGBO(255, 64, 129, .9),
        900: Color.fromRGBO(255, 64, 129, 1),
      })),
      onGenerateRoute: (settings) => customRoute(settings),
      home: const LoginScreen(),
      //Ketik nama class dari screen lain di sini [ home: namaclass(), ]
    );
  }
}
