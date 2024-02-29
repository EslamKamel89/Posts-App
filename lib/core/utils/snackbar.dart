import 'package:flutter/material.dart';

customSnackBar({
  required BuildContext context,
  required String title,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 1),
    ),
  );
}
