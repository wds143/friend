// import 'package:flutter/material.dart';

// class MyButton extends StatelessWidget {
//   final String text;
//   VoidCallback onPressed;
//   MyButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: onPressed,
//       color: Theme.of(context).primaryColor,
//       child: Text(text),
//     );
//   }
// }
// Old code

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed; // Added 'final' keyword here
  MyButton({Key? key, required this.text, required this.onPressed})
      : super(
            key: key); // Moved 'super(key: key)' to constructor initialization

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
