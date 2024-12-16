import 'package:flutter/material.dart';
import 'package:memory_game_vanilla/view/features/main_game/main_game_screen_mixin.dart';
import '../../core/components/game_card.dart';

class MainGameScreen extends StatefulWidget {
  const MainGameScreen({super.key});

  @override
  State<MainGameScreen> createState() => _MainGameScreenState();
}

class _MainGameScreenState extends State<MainGameScreen>
    with MainGameScreenMixin {
  @override
  void initState() {
    super.initState();
    createGameCards();
    generateRandomTurn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setBackGroundColorForTurn,
      appBar: _buildAppBar(),
      floatingActionButton: _refreshButton(),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            child: GameCard(
              isFlipped: gameCards[index].isFlipped,
              color: gameCards[index].color,
              isMatched: gameCards[index].isMatched,
              onTap: state == GameState.secondCardFlipped
                  ? null
                  : () async {
                      flipCard(index);
                      switch (state) {
                        case GameState.idle:
                          cacheBeforeFlippedCard(index);
                          state = state.next;
                          setState(() {});
                          break;
                        case GameState.firstCardFlipped:
                          if (checkCardColorsIsMatch(index)) {
                            changeGameCardsColorAndIsMatchParameters(index);
                            increasePoint();
                            state = GameState.idle;
                            setState(() {});
                          } else {
                            state = state.next;
                            await waitThenChangeState();
                          }
                          break;
                        case GameState.secondCardFlipped:
                          // Imposible case
                          break;
                      }
                    },
            ),
          );
        },
        itemCount: colors.length,
      ),
    );
  }

  FloatingActionButton _refreshButton() {
    return FloatingActionButton(
      onPressed: resetGame,
      child: const Icon(Icons.refresh),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Ali : $scoreAli"),
          Text("Şebnem : $scoreSebnem"),
        ],
      ),
    );
  }
}
