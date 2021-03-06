import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final gameProvider = StateNotifierProvider((_) => Game());
class Game extends StateNotifier<int> {
  Game() : super(0);
  List<TextEditingController> _controllers;
  List<TextEditingController> get controllers => _controllers;

  List<String> _positions = [
    "村人",
    "村人",
    "村人",
    "人狼",
    "人狼",
    "占い師",
    "てるてる",
  ];
  List<String> get positions => _positions;

  int _divinationNum;
  int get divinationNum => _divinationNum;

  set controllers(List<TextEditingController> playerControllers) {
    _controllers = playerControllers;
  }

  void setDivinationNum(int num) {
    _divinationNum = num;
  }

  void shufflePositoins() {
    _positions.shuffle();
  }

  void increment() {
    state++;
  }
}
