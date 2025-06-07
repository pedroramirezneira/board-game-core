import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/blocked_movement.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/vector_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class StandardMovement implements ChessMovement {
  final Vector2 vector;
  final int? limit;

  const StandardMovement(this.vector, {this.limit});

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) =>
      BlockedMovement(
        VectorMovement(vector, limit: limit),
      ).execute(game, from, to);

  @override
  ChessMovement rotate180() => StandardMovement(-vector, limit: limit);

  @override
  String toString() => "StandardMovement(vector: $vector, limit: $limit)";
}
