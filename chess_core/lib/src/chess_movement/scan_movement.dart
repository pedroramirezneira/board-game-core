import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class ScanMovement implements ChessMovement {
  final Vector2 vector;

  const ScanMovement(this.vector);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) =>
      switch (game.board.get(from)) {
        Err() => null,
        Ok(value: null) => execute(game, from + vector, to),
        Ok(value: Piece()) => switch (
              game.movementProvider.execute(game, from, to)) {
            Err() => null,
            Ok(value: final board) => board,
          }
      };

  @override
  ChessMovement rotate180() => ScanMovement(-vector);
}
