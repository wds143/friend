// ignore: avoid_web_libraries_in_flutter
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:friend/data/habit_database.dart';
import 'package:friend/utilities/habit-tile.dart';
import 'package:friend/utilities/monthly_summery.dart';
import 'package:friend/utilities/my_fab.dart';
import 'package:friend/utilities/my_alert_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitHome extends StatefulWidget {
  const HabitHome({super.key});

  @override
  State<HabitHome> createState() => _HabitHomeState();
}

class _HabitHomeState extends State<HabitHome> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("mybox");

  @override
  void initState() {
    // check for first time openning the app
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      // load data from database
      db.loadData();
    }
    // update database
    db.updateDatabase();
    super.initState();
  }

  // checkbox tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context as BuildContext,
      builder: (context) {
        return MyAlertBox(
          hintText: "Enter Habit Name",
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

// Save new habit
  void saveNewHabit() {
    // add new habit to today habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear textfield
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context as BuildContext).pop();
    db.updateDatabase();
  }

// Cancel new habit
  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context as BuildContext).pop();
  }

// habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context as BuildContext,
      builder: (context) {
        return MyAlertBox(
            hintText: db.todaysHabitList[index][0],
            controller: _newHabitNameController,
            onCancel: () => saveExistingHabit(index),
            onSave: cancelDialogBox);
      },
    );
  }

// save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context as BuildContext);
    db.updateDatabase();
  }

// delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView(
        children: [
          // heat_map(monthlysummery)
          MonthlySummary(
              datasets: db.heatMapDataSet, startDate: _myBox.get("START_DATE")),

          ListView.builder(
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return habitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
