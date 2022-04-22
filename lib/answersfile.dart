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
        color: Colors.orange,
        textColor: Colors.black,
        splashColor: Colors.black,
        child: Text(anstxt),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }
}
