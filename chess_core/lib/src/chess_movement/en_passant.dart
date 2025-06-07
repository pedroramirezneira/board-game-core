import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class EnPassant implements ChessMovement {
  final ChessMovement movement;
  final String? otherType;

  const EnPassant(this.movement, {this.otherType});

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    if (movement.execute(game, from, to) == null) {
      return null;
    }
    final vector = (to - from).normalize();
    final position = Vector2(to.x, to.y - vector.y);
    final opponent = switch (game.board.get(position)) {
      Ok() => game.board.get(position).unwrap(),
      Err() => null,
    };
    if (opponent == null ||
        opponent.color == game.currentPlayer ||
        opponent.type != otherType) {
      return null;
    }
    final oldPosition = Vector2(to.x, to.y + vector.y);
    final oldOpponent = switch (game.previousState?.board.get(oldPosition)) {
      Ok() => game.previousState?.board.get(oldPosition).unwrap(),
      Err() => null,
      null => null,
    };
    if (!identical(opponent, oldOpponent)) {
      return null;
    }
    final board = game.board.remove(position);
    if (board is Err) {
      return null;
    }
    return switch (board.unwrap().move(from, to)) {
      Ok(value: final board) => board,
      Err() => null,
    };
  }

  @override
  ChessMovement rotate180() => EnPassant(
        movement.rotate180(),
        otherType: otherType,
      );

  @override
  String toString() => "EnPassant(movement: $movement, otherType: $otherType)";
}
