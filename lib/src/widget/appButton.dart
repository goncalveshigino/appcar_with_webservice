import 'package:flutter/material.dart'; 


// ignore: must_be_immutable
class AppButton extends StatelessWidget {

  AppButton(this.text, {this.onPressed, this.showProgress = false});

  String text;
  Function onPressed;
  bool showProgress;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color(0xff615AAB),
      child: showProgress 
      ?  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
      :  Text( text,  style: TextStyle( fontSize: 16, color: Colors.white)),
      onPressed: onPressed
    );
  }
}