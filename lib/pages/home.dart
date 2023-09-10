// import 'package:flutter/material.dart';
// import 'package:friend/data/database.dart';
// import 'package:friend/utilities/dialog_box.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../utilities/todo_tile.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
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
import 'package:friend/tabs/habit.dart';
import '../tabs/todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.note,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.add_box,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: TodoHome(),
                  ),
                  Center(
                    child: HabitHome(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
