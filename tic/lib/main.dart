import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');

  bool isPlayerX = true; // true for 'X', false for 'O'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player ${isPlayerX ? 'X' : 'O'}\'s turn',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (board[index] == '') {
                        setState(() {
                          board[index] = isPlayerX ? 'X' : 'O';
                          isPlayerX = !isPlayerX;
                          checkWinner();
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  resetGame();
                });
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }

  void checkWinner() {
    for (var i = 0; i < 3; i++) {
      // Check rows
      if (board[i * 3] == board[i * 3 + 1] &&
          board[i * 3 + 1] == board[i * 3 + 2] &&
          board[i * 3] != '') {
        showWinnerDialog(board[i * 3]);
        return;
      }

      // Check columns
      if (board[i] == board[i + 3] &&
          board[i + 3] == board[i + 6] &&
          board[i] != '') {
        showWinnerDialog(board[i]);
        return;
      }
    }

    // Check diagonals
    if (board[0] == board[4] && board[4] == board[8] && board[0] != '') {
      showWinnerDialog(board[0]);
      return;
    }

    if (board[2] == board[4] && board[4] == board[6] && board[2] != '') {
      showWinnerDialog(board[2]);
      return;
    }

    // Check for a draw
    if (!board.contains('')) {
      showDrawDialog();
    }
  }

  void showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Player $winner wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('It\'s a Draw!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      isPlayerX = true;
    });
  }
}
