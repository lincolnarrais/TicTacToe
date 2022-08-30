import 'package:flutter/material.dart' show Color, Colors;

class BoardTile {
  final int id;
  String symbol;
  Color color;
  bool enable;

  BoardTile({
    required this.id,
    this.symbol = '',
    this.color = Colors.black26,
    this.enable = true,
  });
}
