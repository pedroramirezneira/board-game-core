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
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    final lambda = _getLambda(to, from);
    if (lambda == null) {
      return null;
    }
    if (!_isPathClear(game.board, from, to, lambda)) {
      return null;
    }
    final result = game.board.move(from, to);
    if (result is Err) {
      return null;
    }
    return result.unwrap();
  }

  int? _getLambda(Vector2 to, Vector2 from) {
    if (_vector.x == 0 && _vector.y == 0) {
      return null;
    }
    final direction = to - from;
    final lambda = switch (direction.x) {
      _ when direction.x != 0 => (direction.x / _vector.x).abs(),
      _ => (direction.y / _vector.y).abs(),
    };
    if (_vector.x * lambda != direction.x) {
      return null;
    }
    if (_vector.y * lambda != direction.y) {
      return null;
    }
    if (_limit != null && lambda > _limit) {
      return null;
    }
    return lambda.toInt();
  }

  bool _isPathClear(
    Board<Vector2, Piece, Vector2> board,
    Vector2 from,
    Vector2 to,
    int lambda,
  ) {
    for (int i = 1; i < lambda.abs(); i++) {
      final position = from + _vector * i;
      final piece = board.get(position);
      if (piece is Ok && piece.unwrap() != null) {
        return false;
      }
    }
    return true;
  }

  @override
  ChessMovement rotate180() {
    return StandardMovement(vector: _rotate180(_vector), limit: _limit);
  }

  Vector2 _rotate180(Vector2 vector) {
    return Vector2(vector.x * -1, vector.y * -1);
  }

  @override
  String toString() {
    return "StandardMovement(vector: $_vector, limit: $_limit)";
  }
}
