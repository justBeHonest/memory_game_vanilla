import 'package:flutter/material.dart';

class GameCardModel {
  final int index;
  final Color color;
  bool isMatched = false;
  bool isFlipped;

  GameCardModel({
    required this.index,
    required this.color,
    this.isFlipped = false,
  });
}
