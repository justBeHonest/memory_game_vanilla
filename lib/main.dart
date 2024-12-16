import 'package:flutter/material.dart';
import 'package:memory_game_vanilla/view/features/main_game/main_game_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: MainGameScreen(),
      ),
    );
  }
}
