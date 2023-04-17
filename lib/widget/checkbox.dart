import 'package:flutter/material.dart';

TextStyle checkBoxTextStyle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13);

Widget checkBoxForm(
    {required ValueNotifier<bool> isChecked, required String text}) {
  return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(children: <Widget>[
        SizedBox(
            height: 25,
            child: Checkbox(
                value: isChecked.value,
                activeColor: Colors.black,
                onChanged: (value) {
                  isChecked.value = value!;
                })),
        Text(text, style: checkBoxTextStyle),
      ]));
}
