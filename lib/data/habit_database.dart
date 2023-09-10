import 'package:friend/datetime/my_datetime.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box('mybox');

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

  // create initial data
  void createDefaultData() {
    todaysHabitList = [
      ["Walk", false],
      ["Drink Water", false]
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  // load data if already exist
  void laodData() {
    // newday
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    // not newday
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  // update database
  void updateDatabase() {
    // update todays entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    // update changes in the habit list
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
  }

  // habit completed percentage for eachday
  calculateHabitPercentages();
  // load heatmap
  loadHeatMap();

  void calculateHabitPercentages() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    // key: PERCENTAGE_SUMMARY_yyyymmdd
    // value: string of 1decimal number between 0.0-1.0 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent)
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

       // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      // day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
