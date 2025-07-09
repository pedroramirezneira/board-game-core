import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

(Vector2, Piece)? getLastMovedPiece(
  Game<Vector2, Piece, Vector2> game,
  String? pieceType,
) {
  final previousState = game.previousState;
  if (previousState == null) {
    return null;
  }
  final iterable = Iterable.withIterator(() => game.board.getAll());
  for (final (vector, piece) in iterable) {
    if (piece == null || (pieceType != null && piece.type != pieceType)) {
      continue;
    }
    final previousPiece = previousState.board.get(vector);
    if (identical(previousPiece.unwrap(), piece)) {
      continue;
    }
    return (vector, piece);
  }
  return null;
}
