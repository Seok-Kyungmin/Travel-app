import 'package:flutter/material.dart';

TextStyle loginButtonStyle =
const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
// final VoidCallback onPressed;

Widget loginButton(
    {required onPressed,required String text}) {
  return SizedBox(
    height: 45,
    width: 370,
    child: ElevatedButton(

      onPressed: onPressed,
      child: Text(text, style: loginButtonStyle),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Color(0xFFF5F5F5),
        foregroundColor: Colors.black87,
      ),
    ),
  );
}
