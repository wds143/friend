import 'dart:async';
import 'package:flutter/material.dart';

class TimerMechanism extends StatefulWidget {
  const TimerMechanism({super.key});

  @override
  State<TimerMechanism> createState() => _TimerMechanismState();
}

class _TimerMechanismState extends State<TimerMechanism> {
  // variables
  int timeLeft = 5;
  // timer method
  void _startCountDown() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              timeLeft == 0 ? 'DONE' : timeLeft.toString(),
              style: TextStyle(fontSize: 50),
            ),
            MaterialButton(
              onPressed: _startCountDown,
              color: Colors.deepPurple,
              child: Text(
                'START',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
