import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/animation.dart';

import '../widget/titleSection.dart';
import '../widget/textSection.dart';
import '../column/buttonSection.dart';


class MainPageState extends HookConsumerWidget {
  MainPageState({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  get canvas => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Color color = Theme.of(context).primaryColor;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF141212),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text('travel'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                //아이톤 버튼 실행
                print('Shopping cart button is clicked');
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // 아이콘 버튼 실행
                print('Serch button is clicked');
              },
            ),
          ],
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  // 현재 계정 이미지
                  backgroundImage: AssetImage('assets/BF.32098611.1.jpg'),
                  backgroundColor: Colors.white,
                ),
                otherAccountsPictures: <Widget>[
                  // 다른 계정 이미지[] set
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/BF.32098611.1.jpg'),
                  ),
                ],
                accountName: Text('Kyungmin'),
                accountEmail: Text('LV.7 플래티넘'),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                    color: Color(0x1F830034),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.grey[850],
                ),
                title: Text('Home'),
                onTap: () {
                  print("Home is clicked");
                },
                trailing: Icon(Icons.add),

              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('Setting'),
                onTap: () {
                  print("Setting is clicked");
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: Colors.grey[850],
                ),
                title: Text('QnA'),
                onTap: () {
                  print("QnA is clicked");
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
      body: Column(
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
  }
}
