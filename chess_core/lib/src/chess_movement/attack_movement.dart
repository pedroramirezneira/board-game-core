import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class AttackMovement implements ChessMovement {
  final ChessMovement _movement;
  const AttackMovement(ChessMovement movement) : _movement = movement;

  @override
  ChessMovement rotate180() {
    return AttackMovement(_movement.rotate180());
  }

  @override
  Board<Vector2, Piece, Vector2>? execute(
      Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    final piece = game.board.get(to);
    if (piece is Err || piece.unwrap() == null) {
      return null;
    }
    return _movement.execute(game, from, to);
  }
}
