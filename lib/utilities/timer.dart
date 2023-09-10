// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 8, minute: 30);

  // show time picker method
  void _showTimePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );

    if (selectedTime != null && selectedTime != _timeOfDay) {
      setState(() {
        _timeOfDay = selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // display chosen time
            Text(
              _timeOfDay.format(context).toString(),
              style: const TextStyle(fontSize: 50),
            ),
            // button
            MaterialButton(
              onPressed: _showTimePicker,
              color: Colors.blue,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Set Time',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
