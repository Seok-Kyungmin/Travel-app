import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/chatItem.dart';

class ChattingRoom {
  String id;
  String name;

  ChattingRoom(this.id, this.name);
}

class AddChatRoomPage extends HookConsumerWidget {
  AddChatRoomPage({super.key});

// 채팅 문자열 조작을 위한 컨트롤러
  var _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose(); // 사용이 끝나면 해제
    // super.dispose();
  }

  // 채팅방 추가 메서드
  void addChat(ChattingRoom chattingRoom) {
    FirebaseFirestore.instance
        .collection('chattingRoom')
        .add({'name': chattingRoom.name});
    _chatController.text = '';
  }

  // 채팅방 삭제 메서드
  void deleteChat(DocumentSnapshot doc) {
    FirebaseFirestore.instance.collection('chattingRoom').doc(doc.id).delete();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('오픈 채팅'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        decoration: InputDecoration(
                          hintText: '채팅방 이름',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => addChat(ChattingRoom(
                          _chatController.text, _chatController.text)),
                      child: Text('만들기'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('chattingRoom')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final documents = snapshot.data?.docs;
                    return Expanded(
                      child: ListView(
                        children: documents!
                            .map((doc) => buildItemWidget(doc))
                            .toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
