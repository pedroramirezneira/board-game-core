import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/chess_movement_provider.dart';
import 'package:chess_core/src/chess/chess_rule_provider.dart';
import 'package:chess_core/src/chess/chess_turn_manager.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_chess_board.dart';

final Board<Vector2, Piece, Vector2> _board = Board(
  initial: defaultChessBoard,
  size: const Vector2(x: 8, y: 8),
);

Game<Vector2, Piece, Vector2> defaultChess() {
  return Game(
    currentPlayer: "white",
    board: _board,
    movementProvider: ChessMovementProvider(),
    ruleProvider: const ChessRuleProvider(),
    turnManager: const ChessTurnManager(),
    previousState: null,
  );
}
