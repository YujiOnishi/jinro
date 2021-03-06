import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../provider/game.dart';
import '../pages/game.dart';

class StartApp extends HookWidget {
  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  final provider = useProvider(gameProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ワンナイト人狼')),
      body: Center(
        child: Column(
          children: [
            Column(
              children: createPlayerWidgets(),
            ),
            MaterialButton(
              onPressed: () => {start(context)},
              child: Text('スタート！'),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void start(BuildContext context) {
    provider.controllers = controllers;
    provider.shufflePositoins();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameApp(),
      ),
    );
  }

  List<Widget> createPlayerWidgets() {
    List<Widget> players = List<Widget>();
    for (int i = 0; i < 4; i++) {
      players.add(
        Padding(
          padding: EdgeInsets.all(20),
          child: TextFormField(
            controller: controllers[i],
            decoration: const InputDecoration(
              hintText: '参加者の名前',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '参加者は必須入力項目です';
              }
              if (4 < value.length) {
                return '名前は最大4文字までです';
              }
            },
          ),
        ),
      );
    }
    return players;
  }
}
