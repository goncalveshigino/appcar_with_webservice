import 'package:flutter/material.dart'; 

// ignore: must_be_immutable
class AppText extends StatelessWidget {


  AppText(
  this.label, this.hint, {this.password = false, this.controller, 
  this.validator, this.keyboardType, this.focusNode, this.nextFocus, 
  this.textInputAction}
  );

  String label;
  String hint; 
  bool password;
  TextEditingController  controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text){
        if(nextFocus != null){
          FocusScope.of(context).requestFocus(nextFocus);         
        }
          
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(16)
        ),
        labelText: label,
        hintText:   hint,            
      ),
    );
  }
}