import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class VectorMovement implements ChessMovement {
  final Vector2 vector;
  final int? limit;

  const VectorMovement(this.vector, {this.limit});

  @override
  Future<Board<Vector2, Piece, Vector2>?> execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) async => switch ((to - from) / vector) {
    null => null,
    int lambda when limit != null && lambda > limit! => null,
    int() => switch (game.board.move(from, to)) {
      Err() => null,
      Ok(value: final board) => board,
    },
  };

  @override
  ChessMovement rotate180() => VectorMovement(-vector, limit: limit);

  @override
  String toString() => "VectorMovement(vector: $vector, limit: $limit)";
}
