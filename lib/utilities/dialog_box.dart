// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:friend/utilities/buttons.dart';
// // import 'package:friend/utilities/timer_box.dart';

// class DialogBox extends StatelessWidget {
//   final controller;
//   VoidCallback onSave;
//   VoidCallback onCancel;
//   DialogBox({
//     super.key,
//     required this.controller,
//     required this.onSave,
//     required this.onCancel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.yellow[300],
//       content: SizedBox(
//         height: 120,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // User input
//             TextField(
//               controller: controller,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "Add a new task",
//               ),
//             ),
//             // const Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [TimerBox()],
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // add Button
//                 MyButton(text: "Save", onPressed: onSave),

//                 const SizedBox(width: 8),
//                 // cancel Button
//                 MyButton(text: "Cancel", onPressed: onCancel),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// Old Code

import 'package:flutter/material.dart';
import 'package:friend/utilities/buttons.dart';
// import 'package:friend/utilities/timer_box.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSave;
  final void Function() onCancel;

  const DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // User input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [TimerBox()],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // add Button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 8),
                // cancel Button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
