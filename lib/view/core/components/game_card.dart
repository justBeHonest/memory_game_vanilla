import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final Color color;
  final bool isFlipped;
  final bool isMatched;
  final Function()? onTap;

  const GameCard({
    super.key,
    required this.color,
    required this.isFlipped,
    required this.isMatched,
    required this.onTap,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      color: _isMatchedOrIsFlippedForColor,
      child: InkWell(
        onTap: _isMatchedOrIsFlippedForOnTap,
      ),
    );
  }

  Function()? get _isMatchedOrIsFlippedForOnTap =>
      widget.isMatched || widget.isFlipped ? null : widget.onTap;

  Color get _isMatchedOrIsFlippedForColor =>
      widget.isFlipped || widget.isMatched ? widget.color : Colors.white;
}
