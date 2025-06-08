import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';

class ScanMovement implements ChessMovement {
  final Vector2 vector;
  final ChessMovement? onPieceFound;

  const ScanMovement(this.vector, {this.onPieceFound});

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) => switch (game.board.get(from)) {
    Err() => null,
    Ok(value: null) => execute(game, from + vector, to),
    Ok(value: Piece()) => switch (game.movementProvider.execute(
      game,
      from,
      to,
    )) {
      Err() => null,
      Ok(value: final board) when onPieceFound == null => board,
      Ok(value: final board) =>
        onPieceFound!.execute(game, from, to) == null ? null : board,
    },
  };

  @override
  ChessMovement rotate180() =>
      ScanMovement(-vector, onPieceFound: onPieceFound?.rotate180());
}
