import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.addButtonText,
    this.onTap,
  });

  final String addButtonText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 100,
          height: 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: Text(
            addButtonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
