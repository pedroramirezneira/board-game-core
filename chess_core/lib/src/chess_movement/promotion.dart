import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/promotion_event.dart';

class Promotion implements ChessMovement {
  final ChessMovement movement;

  const Promotion(this.movement);

  @override
  Future<Board<Vector2, Piece, Vector2>?> execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) async {
    final isValid = switch (game.currentPlayer) {
      "white" => to.y == game.board.size.y - 1,
      "black" => to.y == 0,
      _ => false,
    };
    if (!isValid) {
      return movement.execute(game, from, to);
    }
    final pieceType = await game.input(PromotionEvent());
    return switch (await movement.execute(game, from, to)) {
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
    return Promotion(movement.rotate180());
  }
}
