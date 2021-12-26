import 'package:finger_print_login/pages/fingerprint_auth_page.dart';
import 'package:finger_print_login/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FingerPrintAuthPage(),
      // themeMode: ThemeMode.dark,
      // theme: ThemeData(
      //   primaryColor: Colors.black,
      //   scaffoldBackgroundColor: Colors.blueGrey.shade900,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //   ),
      // ),
      // home: HomePage(),
    );
  }
}

