import 'package:flutter/material.dart';
import 'view/game_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Şifre Kırıcı',
      home: GameView(),
    );
  }
}
