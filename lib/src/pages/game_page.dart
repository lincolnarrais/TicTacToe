import 'package:flutter/material.dart';
import 'package:tictactoe/src/enums/player_type.dart';
import 'package:tictactoe/src/enums/winner_type.dart';

import '../controllers/game_controller.dart';
import '../core/constants.dart';
import '../widgets/custom_dialog.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(kGameTitle),
      centerTitle: true,
    );
  }

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBoard(),
        _buildPlayerMode(),
        _buildResetButton(),
      ],
    );
  }

  Widget _buildBoard() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: kBoardSize,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: _buildTile,
      ),
    );
  }

  Widget _buildTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _onMarkTile(index),
      child: Container(
        color: _controller.tiles[index].color,
        child: Center(
          child: Text(
            _controller.tiles[index].symbol,
            style: const TextStyle(
              fontSize: 72.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _onMarkTile(int index) {
    if (!_controller.tiles[index].enable) return;

    setState(() {
      _controller.markBoardTileByIndex(index);
    });

    _checkWinner();
  }

  void _checkWinner() {
    var winner = _controller.checkWinner();
    if (winner == WinnerType.none) {
      if (!_controller.hasMoves) {
        _showTiedDialog();
      } else if (_controller.isSinglePlayer &&
          _controller.currentPlayer == PlayerType.player2) {
        final index = _controller.automaticMove();
        _onMarkTile(index);
      }
    } else {
      String symbol =
          winner == WinnerType.player1 ? kPlayer1Symbol : kPlayer2Symbol;
      _showWinnerDialog(symbol);
    }
  }

  void _showTiedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: kTiedTitle,
          message: kDialogMessage,
          onPressed: _onResetGame,
        );
      },
    );
  }

  void _showWinnerDialog(String symbol) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CustomDialog(
          title: kWinTitle.replaceAll('[SYMBOL]', symbol),
          message: kDialogMessage,
          onPressed: _onResetGame,
        );
      },
    );
  }

  void _onResetGame() {
    setState(() {
      _controller.reset();
    });
  }

  _buildPlayerMode() {
    return SwitchListTile(
      title: Text(_controller.isSinglePlayer ? 'Single Player' : 'Two Players'),
      secondary: Icon(_controller.isSinglePlayer ? Icons.person : Icons.group),
      value: _controller.isSinglePlayer,
      onChanged: (value) {
        setState(() {
          _controller.isSinglePlayer = value;
        });
      },
    );
  }

  _buildResetButton() {
    return ElevatedButton(
      onPressed: _onResetGame,
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(kResetButtonLabel),
      ),
    );
  }
}
