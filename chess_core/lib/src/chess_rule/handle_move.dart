import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

Future<bool> handleMove(
  Vector2 from,
  Vector2 to,
  Game<Vector2, Piece, Vector2> game,
  String? pieceType,
) async {
  final piece = game.board.get(to);
  if (piece is Err ||
      pieceType != null && (piece.unwrap()?.type != pieceType)) {
    return false;
  }
  if (piece.unwrap()?.color != game.previousState?.currentPlayer) {
    return false;
  }
  final movement = await game.movementProvider.execute(game, from, to);
  if (movement is Err) {
    return false;
  }
  return true;
}
