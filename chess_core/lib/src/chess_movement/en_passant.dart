import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class EnPassant implements ChessMovement {
  final String otherType;
  final Vector2 vector;

  const EnPassant(this.otherType, this.vector);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    final direction = to - from;
    final position = switch (direction) {
      _ when direction.y > 0 => Vector2(to.x, to.y - 1),
      _ => Vector2(to.x, to.y + 1),
    };
    final opponent = switch (game.board.get(position)) {
      Ok() => game.board.get(position).unwrap(),
      Err() => null,
    };
    if (opponent == null ||
        opponent.color == game.currentPlayer ||
        opponent.type != otherType) {
      return null;
    }
    final oldPosition = switch (direction) {
      _ when direction.y > 0 => Vector2(to.x, to.y + 1),
      _ => Vector2(to.x, to.y - 1),
    };
    final oldOpponent = switch (game.previousState?.board.get(oldPosition)) {
      Ok() => game.previousState?.board.get(oldPosition).unwrap(),
      Err() => null,
      null => null,
    };
    if (!identical(opponent, oldOpponent)) {
      return null;
    }
    final movement = PeacefulMovement(StandardMovement(vector: vector));
    if (movement.execute(game, from, to) == null) {
      return null;
    }
    final board = game.board.remove(position);
    if (board is Err) {
      return null;
    }
    final result = board.unwrap().move(from, to);
    return switch (result) {
      Ok() => result.unwrap(),
      Err() => null,
    };
  }

  @override
  ChessMovement rotate180() => EnPassant(otherType, _rotate180(vector));

  Vector2 _rotate180(Vector2 vector) {
    return Vector2(vector.x * -1, vector.y * -1);
  }
}
