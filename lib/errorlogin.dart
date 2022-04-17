import 'package:flutter/material.dart';

class error extends StatelessWidget {
  const error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Scaffold(
          body: Center(
            child: Text(
              'Log-in Failed!!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
