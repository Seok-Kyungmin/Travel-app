import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void ex2() {
  for (int i = 1; i < 7; i++) {
    var stars = '';
    for (int j = 0; j < i; j++) {
      stars += '★';
    }
    for (int j = 6; j > i; j--) {
      stars += '☆';
    }
    print(stars);
  }
  for (int i = 1; i < 6; i++) {
    var stars = '';
    for (int j = 6; j > i; j--) {
      stars += '★';
    }
    for (int j = 0; j < i; j++) {
      stars += '☆';
    }
    print(stars);
  }
}

void ex1() {
  for (int i = 1; i < 50; i++) {
    print(i);
  }
}
List<IconData> userIcon = [
  Icons.person,
  Icons.person,
  Icons.person,
  Icons.person,
];

List<Color> colorList = [
  Colors.red,
  Colors.blue,
  Colors.amber,
  Colors.green
];

List<Map<String,String>> userInfoList = [
  {'name': 'Nurcahyo Budi Nugroho', 'info': 'Sistem Informasi', 'date': '2015'},
  {'name': 'Mulia Dewi', 'info': 'Manajemen  Informatika', 'date': '2019'},
  {'name': 'Tom Cruise', 'info': 'Teknik Komputer', 'date': '2017'},
  {'name': 'Leonardo DiCaprio', 'info': 'Ekonomi', 'date': '2019'}
];

void ex3() {
  print(userInfoList.toString());
}

class FreindPage extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Nurcahyo (KELAS)',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: userInfoList.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(userIcon[index], color: colorList[index],),
                    trailing: Text(userInfoList[index]['date']!, style: TextStyle(fontSize: 17),),
                    title: Text(userInfoList[index]['name']!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    subtitle: Text(userInfoList[index]['info']!),
                  ),
                );
              }
            ),
          ))
          // TextButton(
          //     onPressed: () {
          //       ex3();
          //     },
          //     child: Text("TEXT BUTTON"))
        ],
      ),
    );
  }
}
