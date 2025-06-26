import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class ExplosiveMovement implements ChessMovement {
  final ChessMovement movement;
  final int radius;

  const ExplosiveMovement(this.movement, this.radius);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    final board = movement.execute(game, from, to);
    if (board == null) {
      return null;
    }
    final left = to.x - radius;
    final right = to.x + radius;
    final bottom = to.y - radius;
    final top = to.y + radius;
    var newBoard = board;
    for (var x = left; x <= right; x++) {
      for (var y = bottom; y <= top; y++) {
        final target = Vector2(x, y);
        if (target == to) {
          continue;
        }
        switch (newBoard.remove(target)) {
          case Ok(value: final board):
            newBoard = board;
          case Err():
            null;
        }
      }
    }
    return newBoard;
  }

  @override
  ChessMovement rotate180() => ExplosiveMovement(movement.rotate180(), radius);
}
