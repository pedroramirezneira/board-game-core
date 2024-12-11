import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/chess_end_provider.dart';
import 'package:chess_core/src/chess/chess_movement_provider.dart';
import 'package:chess_core/src/chess/chess_rule_provider.dart';
import 'package:chess_core/src/chess/chess_turn_manager.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_chess_board.dart';

final _board = Board(
  initial: defaultChessBoard,
  size: const Vector2(8, 8),
  toString: (board) {
    final buffer = StringBuffer();
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        final piece = board.get(Vector2(j, i));
        buffer.write("|${piece.unwrap()?.type}".padRight(7));
        if (j == 7 && i == 7) {
          buffer.write("|");
        } else if (j == 7) {
          buffer.writeln("|");
        }
      }
    }
    return buffer.toString();
  },
);

Game<Vector2, Piece, Vector2> defaultChess() {
  return Game(
    currentPlayer: "white",
    board: _board,
    movementProvider: ChessMovementProvider(),
    ruleProvider: const ChessRuleProvider(),
    endProvider: const ChessEndProvider(),
    turnManager: const ChessTurnManager(),
    previousState: null,
  );
}
