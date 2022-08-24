

import 'package:flutter/material.dart';
import 'package:rare_crew_test/src/view/pages/auth/screens/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  LoginPage(),
    );
  }
}
