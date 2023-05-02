// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
//
//
// // 검색창 입력내용 controller
// TextEditingController searchTextEditingController = TextEditingController();
// // DB에서 검색된 사용자를 가져오는데 활용되는 변수
// Future<QuerySnapshot> futureSearchResults;
//
// // X 아이콘 클릭시 검색어 삭제
// emptyTheTextFormField() {
//   searchTextEditingController.clear();
// }
//
// // 검색어 입력후 submit하게되면 DB에서 검색어와 일치하거나 포함하는 결과 가져와서 future변수에 저장
// controlSearching(str) {
//   print(str);
//   Future<QuerySnapshot> allUsers = userReference.where('profileName', isGreaterThanOrEqualTo:
//   str).get();
//   useState(() {
//     futureSearchResults = allUsers;
//   });
// }
//
// // 검색페이지 상단부분
// AppBar searchPageHeader() {
//
// }