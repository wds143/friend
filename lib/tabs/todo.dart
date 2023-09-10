// import 'package:flutter/material.dart';
// import 'package:friend/data/database.dart';
// import 'package:friend/utilities/dialog_box.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../utilities/todo_tile.dart';

// class TodoHome extends StatefulWidget {
//   const TodoHome({super.key});

//   @override
//   State<TodoHome> createState() => _TodoHomeState();
// }

// class _TodoHomeState extends State<TodoHome> {
//   // refrence the hive box
//   final _myBox = Hive.box('mybox');
//   ToDoDataBase db = ToDoDataBase();

//   @override
//   void initState() {
//     // create default data first time running the app
//     if (_myBox.get("TODOLIST") == null) {
//       db.createInitialData();
//     } else {
//       // not the first time running the app
//       db.loadData();
//     }
//     super.initState();
//   }

//   // text Controller
//   final _controller = TextEditingController();

//   // checked
//   void checkBoxChanged(bool? value, int index) {
//     setState(() {
//       db.toDoList[index][1] = !db.toDoList[index][1];
//     });
//     Navigator.of(context).pop();
//     db.updateDatabase();
//   }

//   // save task
//   void saveNewTask() {
//     setState(() {
//       db.toDoList.add([_controller.text, false]);
//       _controller.clear();
//     });
//     db.updateDatabase();
//   }

//   // create a new task
//   void createNewTask() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return DialogBox(
//           controller: _controller,
//           onSave: saveNewTask,
//           onCancel: () => Navigator.of(context).pop(),
//         );
//       },
//     );
//   }

//   // delete task
//   void deleteTask(int index) {
//     setState(() {
//       db.toDoList.removeAt(index);
//     });
//     db.updateDatabase();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.yellow[200],
//       appBar: AppBar(
//         title: const Text('FRIEND'),
//         elevation: 0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: createNewTask,
//         child: const Icon(Icons.add),
//       ),
//       body: ListView.builder(
//         itemCount: db.toDoList.length,
//         itemBuilder: (context, index) {
//           return ToDoTile(
//             taskName: db.toDoList[index][0],
//             taskCompleted: db.toDoList[index][1],
//             onChanged: (value) => checkBoxChanged(value, index),
//             deleteFunction: (context) => deleteTask(index),
//           );
//         },
//       ),
//     );
//   }
// }
// Old Code

import 'package:flutter/material.dart';
import 'package:friend/data/database.dart';
import 'package:friend/utilities/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utilities/todo_tile.dart';

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // void checkBoxChanged(bool? value, int index) {
  //   setState(() {
  //     db.toDoList[index][1] = !db.toDoList[index][1];
  //   });
  //   Navigator.of(context).pop();
  //   db.updateDatabase();
  // }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false; // Update completion status
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[200],
      child: Column(
        children: [
          AppBar(
            title: const Text('FRIEND'),
            elevation: 0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: createNewTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
