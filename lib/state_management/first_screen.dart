import 'package:demo/state_management/second_screen.dart';
import 'package:flutter/material.dart';

firstScreenState? mstate;

class firstScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    mstate = firstScreenState();
    return mstate!;
  }
}

class firstScreenState extends State<firstScreen> {
  String value = 'Hello';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            SecondScreen()
          ],
        ),
      ),
    );
  }

  changeValue(String? v) {
    setState(() {
      value = v!;
    });
  }
}
