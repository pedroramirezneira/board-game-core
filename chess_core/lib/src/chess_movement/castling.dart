import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Castling implements ChessMovement {
  final String thisType;
  final String otherType;

  const Castling(this.thisType, this.otherType);

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
