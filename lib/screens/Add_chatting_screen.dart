import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internship/model/model_userfriend.dart';

import '../component/register.dart';
import '../component/validator.dart';
import '../widget/textfield.dart';

// void _addChat(Chat chat) {
//   _items.add(chat); // 초기화
// //     _friendController.text = ''; // 친구 입력 필드를 비움
// }


class addChatRoom extends HookConsumerWidget {
  addChatRoom({super.key});

  bool isMakeRoom = true;
  final authentication = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final roomName = useValueNotifier('');
    final TextEditingController _nameController = useTextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            // 채팅방 이름
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // Page Title
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      '오픈 채팅방 만들기',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),

                  // 채팅방 이름 텍스트 필드
                  Padding(
                    padding: EdgeInsets.only(top: 90),
                    child: TextFormField(
                      key: ValueKey(1),
                      controller: _nameController,
                      validator: namevalidator,
                      onSaved: (value) {
                        roomName.value = value!;
                      },
                      onChanged: (String value) {
                        tryValidation(_formKey);
                      },
                      decoration: registerDecoration(hint: '채팅방 이름을 입력해주세요'),
                    ),
                  ),

                  // 버튼
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("확인"),
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

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              if(isMakeRoom) {
                                tryValidation(_formKey);

                                // try {
                                //   final newRoom = await authentication.collection('chattingRoom').add({'name':chattingRoom.name});
                                //
                                // }
                              }
                            },
                            child: Text("취소"),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.indigo[100],
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
