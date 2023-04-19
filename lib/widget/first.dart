import 'package:flutter/material.dart';
import '../column/buttonSection.dart';
import '../widget/textSection.dart';
import '../widget/titleSection.dart';

Color color = Colors.indigo;

Widget firstPage =  SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/lake.webp',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButtonColumn(color, Icons.call, 'CALL'),
                  buildButtonColumn(color, Icons.near_me, 'ROUTE'),
                  buildButtonColumn(color, Icons.share, 'SHARE'),
                ]
            ),
            textSection,
          ],
        ),

    );