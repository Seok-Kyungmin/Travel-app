import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/animation.dart';

import '../widget/first.dart';
import 'chatlist_screen.dart';
import 'friend_screen.dart';

class MainPageState extends HookConsumerWidget {
  MainPageState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color color = Theme.of(context).primaryColor;

    final _widgetOptions = [
      //이게 하나하나의 화면이되고, Text등을 사용하거나, dart파일에 있는 class를 넣는다.
      HomePage,
      ChatPage(),
      AddChatRoomPage(),
    ];

    ValueNotifier<int> _selectedIndex = useState(0);
    void _onItemTapped(int index) {
      _selectedIndex.value = index;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF141212),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('travel'),
        centerTitle: true,
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

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex.value),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chatting'),
          BottomNavigationBarItem(icon: Icon(Icons.add_comment), label: 'Add Chatting Room'),
          // BottomNavigationBarItem(icon: Icon(Icons.add_comment), label: 'lala'),
        ],
        currentIndex: _selectedIndex.value,
        selectedItemColor: Colors.indigoAccent[800],
        onTap: (int index){
          _onItemTapped(index);
        }

        // _onItemTapped,
      ),
    );
  }
}
