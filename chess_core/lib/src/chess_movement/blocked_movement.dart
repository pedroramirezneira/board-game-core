import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class BlockedMovement implements ChessMovement {
  final ChessMovement movement;

  const BlockedMovement(this.movement);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    final delta = to - from;
    final vector = delta.normalize();
    final lambda = delta / vector;
    if (lambda == null) {
      return null;
    }
    for (var i = 1; i < lambda; i++) {
      final next = from + vector * i;
      if (switch (game.board.get(next)) {
        Err() => true,
        Ok(value: null) => false,
        Ok() => true,
      }) {
        return null;
      }
    }
    return movement.execute(game, from, to);
  }

  @override
  ChessMovement rotate180() => BlockedMovement(movement.rotate180());

  @override
  String toString() => 'BlockedMovement($movement)';
}
