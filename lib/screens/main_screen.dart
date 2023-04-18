import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class MainPageState extends HookConsumerWidget {
  MainPageState({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF141212),
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text('main page'),
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
                accountEmail: Text('test@email.com'),
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
          children: <Widget>[
            Container(
              height: 200,
              color: Color(0xFFDCE3FF),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 단축어 cro
                  children: <Widget>[
                    // 단축어 cir
                    // 이미지 넣기
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/BF.32098611.1.jpg'),
                          radius: 60,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(
                              color: Colors.white, letterSpacing: 2.0),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Kim Hyunjin',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Little Prince Power Level',
              style: TextStyle(
                color: Colors.grey,
                letterSpacing: 2.0,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              '14',
              style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(Icons.check_circle_outline),
                SizedBox(width: 10),
                Text(
                  'face hero tatto',
                  style: TextStyle(fontSize: 16, letterSpacing: 1),
                )
              ],
            ),
          ],
        ));
  }
}
