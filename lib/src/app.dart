

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rare_crew_test/src/view/pages/auth/screens/login.dart';
import 'package:rare_crew_test/src/view/utils/constants.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    log("LifecycleWatcherState#didChangeAppLifecycleState state=${state.toString()}");
    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
    await Hive.close();
    }
    if (state == AppLifecycleState.resumed) {
    await Hive.openBox(Constants.taskBoxName);
    //await Hive.openBox(Constants.userBoxName);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorKey: Constants.navigatorKey,
      home:  const LoginPage(),
    );
  }
}
