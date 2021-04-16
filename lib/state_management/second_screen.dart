import 'package:demo/state_management/first_screen.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        mstate!.changeValue('flutter');
      },
      child: Text('Change'),
    );
  }
}
