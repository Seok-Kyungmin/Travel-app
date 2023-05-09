import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/addChat_screen.dart';
import '../screens/chatList_screen.dart';
import '../screens/chatRoom_screen.dart';
import '../screens/chattingRoom_screen.dart';

// 채팅방 목록을 ListTile 형태로 변경하는 메서드
Widget buildItemWidget(DocumentSnapshot doc) {
  final chatRoom = ChatRoom(doc['roomName'], doc.id);
  final context = CandyGlobalVariable.naviagatorState.currentContext;
  return ListTile(
    title: Text(chatRoom.roomName),
    onTap: () {
      Navigator.push(
          context!,
          MaterialPageRoute(
              builder: (context) => ChatRoomPage()));
      debugPrint(chatRoom.roomName);
    },
    trailing: IconButton(
      icon: Icon(Icons.delete_forever),
      onPressed: () {
        ChatListPage().deleteChat(doc);
      }, // Todo : 쓰레기통 클릭 시 삭제되도록 수정
    ),
  );
}

// // 채팅방 목록을 ListTile 형태로 변경하는 메서드
// Widget buildItemWidget2(DocumentSnapshot doc) {
//   final chatRoom = ChatRoom(doc['roomName'], doc.id);
//   final context = CandyGlobalVariable.naviagatorState.currentContext;
//   return ListTile(
//     title: Text(chatRoom.roomName),
//     onTap: () {
//       Navigator.push(context!, MaterialPageRoute(
//           builder: (context) => ChattingRoomPage(chatRoom: chatRoom)));
//       debugPrint(chatRoom.roomName);
//     },
//   );
// }

Widget buildItemWidget2(DocumentSnapshot doc) {
  final chatRoom = ChatRoom(doc['roomName'], doc.id);
  final context = CandyGlobalVariable.naviagatorState.currentContext;

  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[200],
        ),
        title: Text(chatRoom.roomName),
        onTap: () {
          Navigator.push(
              context!,
              MaterialPageRoute(
                  builder: (context) => ChattingRoomPage(chatRoom: chatRoom)));
          debugPrint(chatRoom.roomName);
        },
      ),
    ),
  );
}

Widget buildItemWidget3(DocumentSnapshot doc) {
  final chatRoom = ChatRoom(doc['roomName'], doc.id);
  final context = CandyGlobalVariable.naviagatorState.currentContext;

  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[200],
        ),
        title: Text(chatRoom.roomName),
        onTap: () {
          Navigator.push(
              context!,
              MaterialPageRoute(
                  builder: (context) => ChatRoomPage()));
          debugPrint(chatRoom.roomName);
        },
      ),
    ),
  );
}
