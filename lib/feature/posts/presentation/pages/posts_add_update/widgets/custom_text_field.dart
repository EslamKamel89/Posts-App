import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.controller,
    this.numberOfLines = 1,
    this.validator,
    this.fieldContent,
  });
  final String title;
  final int numberOfLines;
  final String? Function(String?)? validator;
  final String? fieldContent;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      minLines: numberOfLines,
      maxLines: numberOfLines,
      autocorrect: false,
    );
  }
}
