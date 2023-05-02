import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChattingRoomPage extends HookConsumerWidget{

  @override
  Widget build(BuildContext context, WidgetRef ref){

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Chctting Room')
          ],
        ),
      ),
    );
  }
}