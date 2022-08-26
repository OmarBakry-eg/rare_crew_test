import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rare_crew_test/src/models/task_model.dart';
import 'package:rare_crew_test/src/view/utils/constants.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDoc = await getApplicationDocumentsDirectory();
  Hive.init(appDoc.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.openBox(Constants.taskBoxName);
 // Hive.openBox(Constants.userBoxName);
  runApp(const ProviderScope(child: MyApp()));
}
