import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../provider/game.dart';

class GameApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(gameProvider);
    useProvider(gameProvider.state);

    return Scaffold(
      appBar: AppBar(title: Text('役職')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                getMasterText(provider),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                getDivinationResultText(provider),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: createButton(provider),
            ),
            Column(
              children: createDivinationButtons(provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget createButton(provider) {
    Widget button;
    int count = provider.state;

    if (count >= provider.controllers.length * 2) {
      button = MaterialButton(
        onPressed: () {
          provider.state = 0;
          provider.shufflePositoins();
        },
        child: Text('もう一度する'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
      return button;
    } else if (count >= provider.controllers.length * 2 - 1) {
      button = MaterialButton(
        onPressed: () => {provider.increment()},
        child: Text('占い完了！'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
      return button;
    } else if (count / 2 >= provider.controllers.length - 1) {
      button = Container();
      return button;
    } else {
      button = MaterialButton(
        onPressed: () => {provider.increment()},
        child: Text('イエス'),
        color: Colors.blueAccent,
        textColor: Colors.white,
      );
      return button;
    }
  }

  List<Widget> createDivinationButtons(provider) {
    List<Widget> buttons;
    int count = provider.state;
    if (count >= provider.controllers.length * 2 - 1) {
      buttons = [Container()];
      return buttons;
    } else if (count / 2 >= provider.controllers.length - 1) {
      buttons = [];
      for (int i = 0; i < provider.controllers.length - 1; i++) {
        buttons.add(
          Padding(
            padding: EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: () {
                provider.increment();
                provider.setDivinationNum(i);
              },
              child: Text(provider.controllers[i].text + 'を占う'),
              color: Colors.blueAccent,
              textColor: Colors.white,
            ),
          ),
        );
      }
      buttons.add(
        Padding(
          padding: EdgeInsets.all(20),
          child: MaterialButton(
            onPressed: () {
              provider.increment();
              provider.setDivinationNum(provider.controllers.length);
            },
            child: Text('場を占う'),
            color: Colors.blueAccent,
            textColor: Colors.white,
          ),
        ),
      );
      return buttons;
    } else {
      buttons = [Container()];
      return buttons;
    }
  }

  String getDivinationResultText(provider) {
    String text;
    int count = provider.state;

    if (count >= provider.controllers.length * 2) {
      text = "";
      return text;
    } else if (count >= provider.controllers.length * 2 - 1) {
      int divinationNum = provider.divinationNum;
      if (divinationNum == provider.controllers.length) {
        text = "場の役職は" +
            provider.positions[divinationNum] +
            "と" +
            provider.positions[divinationNum - 1];
      } else {
        text = provider.controllers[divinationNum].text +
            "さんの役職は" +
            provider.positions[divinationNum];
      }
      return text;
    } else {
      text = "";
      return text;
    }
  }

  String getMasterText(provider) {
    String text;
    int count = provider.state;

    if (count >= provider.controllers.length * 2) {
      text = "ゲームスタート！";
      return text;
    } else if (count >= provider.controllers.length * 2 - 1) {
      text = "占い師の方は占い完了ボタンを押してください。";
      return text;
    } else if (count / 2 >= provider.controllers.length - 1) {
      text = "目をつむって机をたたいてください。";
      return text;
    } else if (count % 2 == 0) {
      text = "あなたは" + provider.controllers[count / 2].text + "ですか？";
      return text;
    } else {
      int num = (count / 2).floor();
      text = "あなたの役職は" + provider.positions[num] + "です";
      return text;
    }
  }
}
