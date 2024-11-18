import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class InitialMovement implements ChessMovement {
  final ChessMovement _movement;
  const InitialMovement(ChessMovement movement) : _movement = movement;

  @override
  ChessMovement rotate180() {
    return InitialMovement(_movement.rotate180());
  }

  @override
  bool validate(Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    var state = game.previousState;
    final piece = game.board.get(from).unwrap();
    while (state != null) {
      final oldPiece = state.board.get(from);
      if (oldPiece is Err || !identical(piece, oldPiece.unwrap())) {
        return false;
      }
      state = state.previousState;
    }
    return _movement.validate(game, from, to);
  }
}
