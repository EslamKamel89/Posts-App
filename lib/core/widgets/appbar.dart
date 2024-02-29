import 'package:flutter/material.dart';

class MyAppBar {
  static AppBar def({required String title}) {
    return AppBar(
      title: Text(title),
    );
  }
}
