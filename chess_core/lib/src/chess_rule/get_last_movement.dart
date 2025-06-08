import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_rule/get_last_moved_piece.dart';

(Vector2, Vector2, Piece)? getLastMovement(
  Game<Vector2, Piece, Vector2> game,
  String? pieceType,
) {
  final previousState = game.previousState;
  if (previousState == null) {
    return null;
  }
  final lastMovedPiece = getLastMovedPiece(game, pieceType);
  if (lastMovedPiece == null) {
    return null;
  }
  final (movedVector, movedPiece) = lastMovedPiece;
  final iterable = Iterable.withIterator(() => previousState.board.getAll());
  for (final Pair(first: vector, second: piece) in iterable) {
    if (piece != movedPiece) {
      continue;
    }
    return (vector, movedVector, movedPiece);
  }
  return null;
}
