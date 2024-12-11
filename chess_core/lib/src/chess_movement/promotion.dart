import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class Promotion implements ChessMovement {
  final ChessMovement _movement;
  final String _pieceType;

  const Promotion(ChessMovement movement, String pieceType)
      : _movement = movement,
        _pieceType = pieceType;

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
      return _movement.execute(game, from, to);
    }
    return switch (_movement.execute(game, from, to)) {
      null => null,
      _ => game.board
          .remove(from)
          .unwrap()
          .put(to, Piece(type: _pieceType, color: game.currentPlayer))
          .unwrap(),
    };
  }

  @override
  ChessMovement rotate180() {
    return Promotion(_movement.rotate180(), _pieceType);
  }
}
