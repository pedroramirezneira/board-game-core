import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class EnPassant implements ChessMovement {
  final String pieceType;

  const EnPassant(this.pieceType);

  @override
  Board<Vector2, Piece, Vector2>? execute(
      Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    return null;
  }

  @override
  ChessMovement rotate180() {
    return this;
  }
}
