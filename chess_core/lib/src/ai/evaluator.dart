import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:board_game_core/board_game_core.dart';

int evaluate(Game<Vector2, Piece, Vector2> game) {
  int score = 0;
  final iterator = game.board.getAll();

  const values = {
    'pawn': 100,
    'knight': 320,
    'bishop': 330,
    'rook': 500,
    'queen': 900,
    'king': 20000,
  };

  while (iterator.moveNext()) {
    final piece = iterator.current.second;
    if (piece == null) continue;

    final value = values[piece.type] ?? 0;
    score += piece.color == 'white' ? value : -value;
  }

  return score;
}
