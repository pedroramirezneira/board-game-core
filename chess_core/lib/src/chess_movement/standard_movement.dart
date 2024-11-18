import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class StandardMovement implements ChessMovement {
  final Vector2 _vector;
  final int? _limit;
  const StandardMovement({required Vector2 vector, int? limit})
      : _vector = vector,
        _limit = limit;
  @override
  bool validate(Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    final direction = to - from;
    final lambda =
        _vector.x == 0 ? direction.y / _vector.y : direction.x / _vector.x;
    if (lambda < 0) {
      return false;
    }
    if (_vector.y * lambda != direction.y) {
      return false;
    }
    if (_limit != null && lambda > _limit) {
      return false;
    }
    return true;
  }

  @override
  ChessMovement rotate180() {
    return StandardMovement(vector: _rotate180(_vector), limit: _limit);
  }

  Vector2 _rotate180(Vector2 vector) {
    return Vector2(x: vector.x * -1, y: vector.y * -1);
  }
}
