import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class Kamikaze implements ChessMovement {
  final ChessMovement movement;

  const Kamikaze(this.movement);

  @override
  Future<Board<Vector2, Piece, Vector2>?> execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) async => switch (await movement.execute(game, from, to)) {
    null => null,
    Board<Vector2, Piece, Vector2> board => board.remove(to).unwrap(),
  };

  @override
  ChessMovement rotate180() => Kamikaze(movement.rotate180());
}
