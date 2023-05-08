import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'chatRoom_screen.dart';
import 'chatlist_screen.dart';

class ChattingRoomPage extends HookConsumerWidget {
  ChattingRoomPage({Key? key, required this.chattingRoom}) : super(key: key);

  final ChattingRoom chattingRoom;
  String id = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late TextEditingController _idController = TextEditingController();
    void submit() {
      Navigator.of(context).pop(_idController.text);
      print(_idController.text);
    }

    // 다이얼로그에서 버튼 클릭 시 호출되는 함수
    void onButtonPressed() async {
      // 다이얼로그에서 입력받은 값 가져오기
      String ID = _idController.text;

      // Firebase에서 가져온 데이터와 비교
      if (chattingRoom.id == ID) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatRoomPage()));
      } else {
        _errorMessage = '채팅방 코드와 일치하지 않습니다';
      }
    }

    Future<String?> openDialog() => showDialog<String>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('참여 코드 입력'),
            content: TextField(
              maxLength: 20,
              autofocus: true,
              decoration: InputDecoration(hintText: '영문/숫자 20자리'),
              controller: _idController,
            ),
            actions: [
              TextButton(
                onPressed: onButtonPressed,
                child: Text('확인'),
              ),
            ],
          ),
        );

    return Scaffold(
        appBar: AppBar(
          title: Text('오픈 채팅'),
        ),
        body: Column(
          children: [
            const SizedBox(
              width: 12,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text(chattingRoom.name, style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.all(32),
              child: ElevatedButton(
                child: Text('그룹 채팅 참여하기'),
                onPressed: () async {
                  final id = await openDialog();
                  if (id == null || id.isEmpty) return;
                  this.id = id;
                },
              ),
            ),
          ],
        ));
  }
}
