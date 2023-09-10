import 'dart:async';
import 'package:flutter/material.dart';

class TimerMechanism extends StatefulWidget {
  const TimerMechanism({Key? key}) : super(key: key);

  @override
  State<TimerMechanism> createState() => _TimerMechanismState();
}

class _TimerMechanismState extends State<TimerMechanism> {
  // Variables
  int timeLeft = 300; // 5 minutes = 300 seconds
  bool isCountingDown = false;
  late Timer _timer;

  // Timer method
  void _startCountDown() {
    if (!isCountingDown) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeLeft > 0) {
          setState(() {
            timeLeft--;
          });
        } else {
          timer.cancel();
          setState(() {
            isCountingDown = false;
          });
        }
      });
      setState(() {
        isCountingDown = true;
      });
    }
  }

  @override
  void dispose() {
    if (isCountingDown) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              isCountingDown ? timeLeft.toString() : 'DONE',
              style: TextStyle(fontSize: 50),
            ),
            MaterialButton(
              onPressed: _startCountDown,
              color: Colors.deepPurple,
              child: Text(
                isCountingDown ? 'PAUSE' : 'START',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
