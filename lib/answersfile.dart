import 'dart:ffi';

import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final VoidCallback selecthandler;
  final String anstxt;
  Answers(this.selecthandler, this.anstxt);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: selecthandler,
        color: Colors.blueGrey,
        textColor: Colors.white,
        child: Text(anstxt),
      ),
    );
  }
}
