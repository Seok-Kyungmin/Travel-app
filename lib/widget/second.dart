import 'package:flutter/material.dart';

Widget secondPage = Column(
  children: [
    Row(
    Text(
      '채팅',
    ),
    ElevatedButton(
      onPressed: () async {},
      child: Text('새로운 채팅'),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    )
  ],
);
