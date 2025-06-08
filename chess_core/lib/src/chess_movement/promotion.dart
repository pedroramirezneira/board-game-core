import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class Promotion implements ChessMovement {
  final ChessMovement movement;
  final String pieceType;

  const Promotion(this.movement, this.pieceType);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    final isValid = switch (game.currentPlayer) {
      "white" => to.y == game.board.size.y - 1,
      "black" => to.y == 0,
      _ => false,
    };
    if (!isValid) {
      return movement.execute(game, from, to);
    }
    return switch (movement.execute(game, from, to)) {
      null => null,
      _ =>
        game.board
            .remove(from)
            .unwrap()
            .put(to, Piece(type: pieceType, color: game.currentPlayer))
            .unwrap(),
    };
  }

  @override
  ChessMovement rotate180() {
    return Promotion(movement.rotate180(), pieceType);
  }
}
