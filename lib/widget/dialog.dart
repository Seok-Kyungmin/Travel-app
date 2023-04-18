import 'package:flutter/material.dart';

Future dialog({required String text, required BuildContext context}) {
  return showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); //창 닫기
                },
                child: Text('OK'),
              ),
            ),
          ],
        );
      }));
}
