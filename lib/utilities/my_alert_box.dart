// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final hintText;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({super.key, required this.controller, required this.onCancel, required this.onSave, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade600,
      content: TextField(
        controller: controller,
        style: const TextStyle(color: ),
        decoration: InputDecoration( hintText: hintText, hintStyle: const TextStyle(color: Colors.grey.shade600),
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Colors.black,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          onPressed: onCancel,
          color: Colors.black,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
