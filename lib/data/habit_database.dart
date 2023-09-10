import 'package:friend/datetime/my_datetime.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitDatabase {
  final _myBox = Hive.box('mybox');
  List<List<dynamic>> todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // Create initial data
  void createDefaultData() {
    todaysHabitList = [
      ["Walk", false],
      ["Drink Water", false]
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // Load data if it already exists
  void loadData() {
    final currentDateKey = todaysDateFormatted();

    if (_myBox.containsKey(currentDateKey)) {
      todaysHabitList = _myBox.get(currentDateKey);
    } else {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST") ?? [];
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
  }

  // Update the database
  void updateDatabase() {
    // Update today's entry
    final currentDateKey = todaysDateFormatted();
    _myBox.put(currentDateKey, todaysHabitList);

    // Update changes in the habit list
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
  }

  // Calculate habit completion percentages for each day
  double calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    return todaysHabitList.isEmpty
        ? 0.0
        : (countCompleted / todaysHabitList.length).toDouble();
  }

  // Load heatmap
  void loadHeatMap() {
    final startDateString = _myBox.get("START_DATE");
    if (startDateString == null) {
      return; // Handle this case
    }
    DateTime startDate = createDateTimeObject(startDateString);

    // Number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // Go from start date to today and add each percentage to the dataset
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // Split the datetime up like below so it doesn't worry about hours/mins/secs etc.
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
