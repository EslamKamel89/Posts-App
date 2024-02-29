import 'package:flutter/material.dart';

class MyAppTheme {
  static final ThemeData light = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.withOpacity(0.8),
      foregroundColor: Colors.white,
    ),
  );
}
