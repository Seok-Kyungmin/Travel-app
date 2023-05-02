import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../class/Search.dart';
import '../widget/chatItem.dart';

class ChatPage extends HookConsumerWidget {
  ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = useState<List<DocumentSnapshot>>([]);
    final TextEditingController _searchController = TextEditingController();
    final List<String> list = List.generate(10, (index) => "Text $index");

    void search(String query) {
      // 데이터를 가져오는 비동기 작업을 실행합니다.
      FirebaseFirestore.instance
          .collection('chattingRoom')
          .where('id', isEqualTo: 'chattingRoom')
          .get()
          .then((querySnapshot) {
        // 검색 결과를 상태에 저장합니다.
        searchResults.value = querySnapshot.docs;
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search(list));
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('Chatting List'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chattingRoom')
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator()
              );
            }

            final documents = snapshot.data?.docs;
            return ListView(
              children: documents!
                  .map((doc) => buildItemWidget2(doc))
                  .toList(),
            );
          }
      ),
    );
  }
}
