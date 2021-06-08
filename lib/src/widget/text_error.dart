import 'package:flutter/material.dart';

class TextError extends StatelessWidget {

  TextError(this.msg, {this.onPressed});

  String msg;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
             msg,
             style: TextStyle(
              color: Colors.red,
              fontSize: 22,
            )),
      ),
    );
  }
}
