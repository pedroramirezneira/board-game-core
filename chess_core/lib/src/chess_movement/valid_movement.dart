import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class ValidMovement implements ChessMovement {
  @override
  Future<Board<Vector2, Piece, Vector2>?> execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) async => game.board;

  @override
  ChessMovement rotate180() => ValidMovement();
}
