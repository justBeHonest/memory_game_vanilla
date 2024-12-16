import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/model/game_card.dart';
import 'main_game_screen.dart';

mixin MainGameScreenMixin on State<MainGameScreen> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Color.fromARGB(179, 168, 251, 2),
    Colors.pink,
    Colors.black,
    Colors.cyan[100] ?? Colors.cyan,
    Colors.indigo,
    Colors.blueGrey,
  ];
  final List<GameCardModel> gameCards = [];
  GameState state = GameState.idle;
  int duration = 500;
  GameCardModel? beforeFlippedCard;
  TurnState turnState = TurnState.ali;
  int scoreAli = 0;
  int scoreSebnem = 0;
  void resetGame() {
    for (var element in gameCards) {
      element.isFlipped = false;
      element.isMatched = false;
    }
    gameCards.shuffle();
    scoreAli = 0;
    scoreSebnem = 0;
    generateRandomTurn();
    setState(() {});
  }

  void generateRandomTurn() {
    turnState = Random().nextBool() ? TurnState.ali : TurnState.sebnem;
  }

  void createGameCards() {
    colors.addAll([...colors]);
    for (var i = 0; i < colors.length; i++) {
      gameCards.add(GameCardModel(index: i, color: colors[i]));
    }
    gameCards.shuffle();
  }

  void setAllCardsToFlippedBack() {
    for (var i = 0; i < gameCards.length; i++) {
      if (!gameCards[i].isMatched) {
        gameCards[i].isFlipped = false;
      }
    }
  }

  get setBackGroundColorForTurn => turnState == TurnState.sebnem
      ? Colors.red.withOpacity(0.3)
      : Colors.blue.withOpacity(0.3);

  Future<void> waitThenChangeState() async {
    duration = 500;
    await Future.delayed(Duration(milliseconds: duration));
    state = GameState.idle;
    setAllCardsToFlippedBack();
    changeTurnState();
    setState(() {});
  }

  void changeTurnState() {
    turnState = turnState.next;
  }

  void increasePoint() {
    turnState == TurnState.ali ? scoreAli++ : scoreSebnem++;
  }

  void changeGameCardsColorAndIsMatchParameters(int index) {
    gameCards
        .where((element) => element.color == gameCards[index].color)
        .forEach((element) {
      element.isMatched = true;
      duration = 0;
    });
  }

  bool checkCardColorsIsMatch(int index) {
    return beforeFlippedCard!.color == gameCards[index].color;
  }

  void cacheBeforeFlippedCard(int index) {
    beforeFlippedCard = gameCards[index];
  }

  void flipCard(int index) {
    gameCards[index].isFlipped = !gameCards[index].isFlipped;
    setState(() {});
  }
}

enum TurnState {
  ali,
  sebnem,
}

extension TurnStateExtension on TurnState {
  TurnState get next {
    switch (this) {
      case TurnState.ali:
        return TurnState.sebnem;
      case TurnState.sebnem:
        return TurnState.ali;
    }
  }
}

enum GameState {
  idle,
  firstCardFlipped,
  secondCardFlipped,
}

extension GameStateExtenison on GameState {
  // change state to next state
  GameState get next {
    switch (this) {
      case GameState.idle:
        return GameState.firstCardFlipped;
      case GameState.firstCardFlipped:
        return GameState.secondCardFlipped;
      case GameState.secondCardFlipped:
        return GameState.idle;
    }
  }
}
