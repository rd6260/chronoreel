import 'package:chronoreel/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChronoReelApp());
}

class ChronoReelApp extends StatelessWidget {
  const ChronoReelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChronoReel",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
