import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import '../widget/chatItem.dart';

final collectionRef = FirebaseFirestore.instance.collection('collection_name');
final sessionId = FirebaseAuth.instance.currentUser!.email;

class ChatRoom {
  String roomName;
  String id;

  ChatRoom(
    this.roomName,
    this.id,
  );
}

class AddChatRoomPage extends HookConsumerWidget {
  bool isAddChatScreen = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isAddChat = false;

  // 채팅 문자열 조작을 위한 컨트롤러
  final TextEditingController _idCon = TextEditingController();
  final TextEditingController _roomNameCon = TextEditingController();
  final TextEditingController _chDateCon = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 문서 생성 (Create)
    void createChat(
      ChatRoom chatRoom,
    ) {
      FirebaseFirestore.instance.collection(sessionId!).add({
        'roomName': chatRoom.roomName,
        'chDatetime': Timestamp.now(),
      });
    }

    // 문서 조회 (Read)
    void showDocument(DocumentSnapshot doc) {
      FirebaseFirestore.instance.collection(sessionId!).doc(doc.id).get();
    }

    // 채팅방 삭제 메서드
    void deleteDoc(DocumentSnapshot doc) {
      FirebaseFirestore.instance.collection(sessionId!).doc(doc.id).delete();
    }

    // 채팅방 생성 Dialog
    void showCreateDocDialog() {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("채팅방 만들기"),
              content: Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      decoration: InputDecoration(labelText: "Name"),
                      controller: _roomNameCon,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    _roomNameCon.clear();
                    _chDateCon.clear();
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Create"),
                  onPressed: () {
                    if (_roomNameCon.text.isNotEmpty) {
                      createChat(ChatRoom(
                        _roomNameCon.text,
                        _idCon.text,
                      ));
                    }
                    _roomNameCon.clear();
                    _idCon.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('오픈 채팅'),
      ),
      body: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(sessionId!).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final documents = snapshot.data?.docs;
            return Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children:
                    documents!.map((doc) => buildItemWidget2(doc)).toList(),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showCreateDocDialog),
    );
  }
}
