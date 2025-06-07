import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class InitialMovement implements ChessMovement {
  final ChessMovement movement;

  const InitialMovement(this.movement);

  @override
  ChessMovement rotate180() {
    return InitialMovement(movement.rotate180());
  }

  @override
  Board<Vector2, Piece, Vector2>? execute(
      Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    var state = game.previousState;
    final piece = game.board.get(from).unwrap();
    while (state != null) {
      final oldPiece = state.board.get(from);
      if (oldPiece is Err || !identical(piece, oldPiece.unwrap())) {
        return null;
      }
      state = state.previousState;
    }
    return movement.execute(game, from, to);
  }
}
