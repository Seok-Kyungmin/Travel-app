import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/chatlist_screen.dart';
import '../screens/chattingRoom_screen.dart';

// 채팅방 목록을 ListTile 형태로 변경하는 메서드
Widget buildItemWidget(DocumentSnapshot doc) {
  final chattingRoom = ChattingRoom(doc.id, doc['name']);
  final context = CandyGlobalVariable.naviagatorState.currentContext;
  return ListTile(
    title: Text(chattingRoom.name),
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(
          builder: (context) => ChattingRoomPage(chattingRoom: chattingRoom)));
      debugPrint(chattingRoom.name);
    },
    trailing: IconButton(
      icon: Icon(Icons.delete_forever),
      onPressed: (){
        AddChatRoomPage().deleteChat(doc);
      },   // Todo : 쓰레기통 클릭 시 삭제되도록 수정
    ),
  );
}

// 채팅방 목록을 ListTile 형태로 변경하는 메서드
Widget buildItemWidget2(DocumentSnapshot doc) {
  final chattingRoom = ChattingRoom(doc.id, doc['name']);
  final context = CandyGlobalVariable.naviagatorState.currentContext;
  return ListTile(
    title: Text(chattingRoom.name),
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(
          builder: (context) => ChattingRoomPage(chattingRoom: chattingRoom)));
      debugPrint(chattingRoom.name);
    },
  );
}




