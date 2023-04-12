import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('main page'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.image), onPressed: null),
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
    );
  }
}
