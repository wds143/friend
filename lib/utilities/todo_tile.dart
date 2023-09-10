// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class ToDoTile extends StatelessWidget {
//   final String taskName;
//   final bool taskCompleted;
//   Function(bool?)? onChanged;
//   Function(BuildContext)? deleteFunction;

//   ToDoTile({
//     super.key,
//     required this.taskName,
//     required this.taskCompleted,
//     required this.onChanged,
//     required this.deleteFunction,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const StretchMotion(),
//           children: [
//             SlidableAction(
//               onPressed: deleteFunction,
//               icon: Icons.delete,
//               backgroundColor: Colors.red.shade400,
//               borderRadius: BorderRadius.circular(12),
//             )
//           ],
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.yellow,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               // Task checkbox
//               Checkbox(
//                   value: taskCompleted,
//                   onChanged: onChanged,
//                   activeColor: Colors.black),
//               // Name of the task
//               Text(
//                 taskName,
//                 style: TextStyle(
//                   decoration: taskCompleted
//                       ? TextDecoration.lineThrough
//                       : TextDecoration.none,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// Old Code

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final ValueChanged<bool?>? onChanged; // Changed to ValueChanged<bool?>
  final void Function(BuildContext)? deleteFunction; // Changed type

  ToDoTile({
    Key? key, // Changed key parameter
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade400,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Task checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              // Name of the task
              Text(
                taskName,
                style: TextStyle(
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
