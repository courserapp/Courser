import 'package:flutter/material.dart';

// From Courser
import 'package:courser/User/login_page.dart';
import 'package:courser/Pages/home_page.dart';

Widget UserSignInCheck(int val) {
  if (val == 0) {
    return LoginPage();
  } else if (val == 1) {
    return MyHomePage();
  }
}
