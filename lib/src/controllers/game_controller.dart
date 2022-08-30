import 'dart:math';

import '../core/constants.dart';
import '../core/winner_rules.dart';
import '../enums/player_type.dart';
import '../enums/winner_type.dart';
import '../models/board_tile.dart';

class GameController {
  List<BoardTile> tiles = [];
  List<int> movesPlayer1 = [];
  List<int> movesPlayer2 = [];
  late PlayerType currentPlayer;
  late bool isSinglePlayer;

  bool get hasMoves => movesPlayer1.length + movesPlayer2.length != kBoardSize;

  GameController() {
    _initialize();
  }

  void _initialize() {
    movesPlayer1.clear();
    movesPlayer2.clear();
    currentPlayer = PlayerType.player1;
    isSinglePlayer = false;
    tiles = List<BoardTile>.generate(
      kBoardSize,
      (index) => BoardTile(id: index + 1),
    );
  }

  void reset() {
    _initialize();
  }

  void markBoardTileByIndex(int index) {
    final tile = tiles[index];
    if (currentPlayer == PlayerType.player1) {
      _markBoardTileWithPlayer1(tile);
    } else {
      _markBoardTileWithPlayer2(tile);
    }

    tile.enable = false;
  }

  void _markBoardTileWithPlayer1(BoardTile tile) {
    tile.symbol = kPlayer1Symbol;
    tile.color = kPlayer1Color;
    movesPlayer1.add(tile.id);
    currentPlayer = PlayerType.player2;
  }

  void _markBoardTileWithPlayer2(BoardTile tile) {
    tile.symbol = kPlayer2Symbol;
    tile.color = kPlayer2Color;
    movesPlayer2.add(tile.id);
    currentPlayer = PlayerType.player1;
  }

  bool _checkPlayerWinner(List<int> moves) {
    // if (moves.contains(1) && moves.contains(2) && moves.contains(3) ||
    //     moves.contains(4) && moves.contains(5) && moves.contains(6) ||
    //     moves.contains(7) && moves.contains(8) && moves.contains(9) ||
    //     moves.contains(1) && moves.contains(4) && moves.contains(7) ||
    //     moves.contains(2) && moves.contains(5) && moves.contains(8) ||
    //     moves.contains(3) && moves.contains(6) && moves.contains(9) ||
    //     moves.contains(1) && moves.contains(5) && moves.contains(9) ||
    //     moves.contains(3) && moves.contains(5) && moves.contains(7)) {
    //   return true;
    // }
    // return false;

    return kWinnerRules.any((rule) =>
        moves.contains(rule[0]) &&
        moves.contains(rule[1]) &&
        moves.contains(rule[2]));
  }

  WinnerType checkWinner() {
    if (_checkPlayerWinner(movesPlayer1)) {
      return WinnerType.player1;
    }
    if (_checkPlayerWinner(movesPlayer2)) {
      return WinnerType.player2;
    }
    return WinnerType.none;
  }

  int automaticMove() {
    var list = List.generate(9, (index) => index + 1);
    list.removeWhere((element) => movesPlayer1.contains(element));
    list.removeWhere((element) => movesPlayer2.contains(element));
    var random = Random();
    var index = random.nextInt(list.length - 1);
    return tiles.indexWhere((tile) => tile.id == list[index]);
  }
}
