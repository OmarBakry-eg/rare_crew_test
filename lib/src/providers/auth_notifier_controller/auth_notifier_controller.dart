import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/src/view/utils/constants.dart';
import '../../resources/database/hive_database.dart';

final authNotifierController =
    ChangeNotifierProvider<AuthNotifierController>((ref) => AuthNotifierController());

class AuthNotifierController extends ChangeNotifier {
  AuthNotifierController() : super();

  final HiveDatabase database = HiveDatabase();
  final GlobalKey<FormState> _loginformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupformKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = '';

  GlobalKey<FormState> formKey(bool signup) => signup ? _signupformKey : _loginformKey;

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
  }

  Future<bool> authenticateUser(bool signup) => _userAuth(signup);

  String? getUserName()  {
    final String? email =  database.getUserIfExsiting();
    username = email ?? '';
    print("username $username");
    notifyListeners();
    return email;
  }

  Future<bool> logout() async {
    username = '';
    return await database.clearBox(Constants.userBoxName);
  }

  String _authMode(bool signup) => signup ? "Signup" : "Login";

  Future<bool> _userAuth(bool signup) async {
    try {
      Constants.showLoading();
      UserCredential credential = signup
          ? await _auth.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            )
          : await _auth.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
      Constants.hideLoading();
      if (credential.user != null &&
          credential.user!.email != null &&
          credential.user!.email!.isNotEmpty) {
        await database.setUser(email: credential.user!.email!);
        log("userdata ${credential.user?.email}");
        clearTextFields();
        return true;
      }
      Constants.errorMessage(description: "error in auth mode ${_authMode(signup)}");
      return false;
    } catch (e) {
      Constants.hideLoading();
      Constants.errorMessage(
          description: "error in auth mode ${_authMode(signup)} within\n$e");
      return false;
    }
  }
}
