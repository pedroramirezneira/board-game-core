import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

(Vector2, Piece)? getLastMovedPiece(
  Game<Vector2, Piece, Vector2> game,
  String? pieceType,
) {
  final iterable = Iterable.withIterator(() => game.board.getAll());
  for (final Pair(first: vector, second: piece) in iterable) {
    if (piece == null || (pieceType != null && piece.type != pieceType)) {
      continue;
    }
    final previousPiece = game.board.get(vector);
    if (previousPiece.unwrap() == piece) {
      continue;
    }
    return (vector, piece);
  }
  return null;
}
