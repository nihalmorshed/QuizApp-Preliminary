import 'dart:ffi';

import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final void Function() selecthandler;
  final String anstxt;
  Answers(this.selecthandler, this.anstxt);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: RaisedButton(
        onPressed: selecthandler,
        elevation: 5,
        color: Colors.teal,
        textColor: Colors.white,
        splashColor: Colors.red,
        child: Text(anstxt),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }
}
