import 'package:flutter/material.dart';
import 'package:ktck_nguyen_hoang_phi_hung/body/game.dart';
import 'package:ktck_nguyen_hoang_phi_hung/layout/layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake.io',
      home: Layout(),
    );
  }
}
