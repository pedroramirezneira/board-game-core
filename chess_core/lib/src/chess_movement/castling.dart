import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/valid_movement.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Castling implements ChessMovement {
  final String thisType;
  final String otherType;

  const Castling(this.thisType, this.otherType);

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    if ((to.x - from.x).abs() != 2) {
      return null;
    }
    if (InitialMovement(ValidMovement()).execute(game, from, from) == null) {
      return null;
    }
    final direction = switch (to.x - from.x > 0) {
      true => _Direction.right,
      false => _Direction.left,
    };
    if (_isInCheck(game, from, direction)) {
      return null;
    }
    final scan = _scan(game, from, direction);
    if (scan == null) {
      return null;
    }
    if (InitialMovement(ValidMovement()).execute(game, scan, scan) == null) {
      return null;
    }
    final destination = switch (direction) {
      _Direction.left => from - Vector2(x: 1, y: 0),
      _Direction.right => from + Vector2(x: 1, y: 0),
    };
    final step = game.movementProvider.execute(game, scan, destination);
    if (step is Err) {
      return null;
    }
    final result = step.unwrap().move(from, to);
    return switch (result) {
      Err() => null,
      Ok() => result.unwrap(),
    };
  }

  Vector2? _scan(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    _Direction direction,
  ) {
    final position = switch (direction) {
      _Direction.left => from - Vector2(x: 1, y: 0),
      _Direction.right => from + Vector2(x: 1, y: 0),
    };
    final piece = game.board.get(position);
    if (piece is Err) {
      return null;
    }
    final result = piece.unwrap();
    return switch (result?.type) {
      null => _scan(game, position, direction),
      _ when result?.type == otherType => position,
      _ => null,
    };
  }

  bool _isInCheck(
    Game<Vector2, Piece, Vector2> game,
    Vector2 position,
    _Direction direction,
  ) {
    final destination = switch (direction) {
      _Direction.left => position - Vector2(x: 1, y: 0),
      _Direction.right => position + Vector2(x: 1, y: 0),
    };
    final step = game.movementProvider.execute(game, position, destination);
    if (step is Err) {
      return true;
    }
    final result = game.copyWith(board: step.unwrap(), previousState: game);
    return Check(thisType).validate(result);
  }

  @override
  ChessMovement rotate180() {
    return this;
  }
}

enum _Direction {
  left,
  right,
}
