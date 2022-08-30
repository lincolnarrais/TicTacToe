import 'package:flutter/material.dart';

import 'src/core/constants.dart';
import 'src/core/theme_app.dart';
import 'src/pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kGameTitle,
      theme: themeApp,
      home: const GamePage(),
    );
  }
}
