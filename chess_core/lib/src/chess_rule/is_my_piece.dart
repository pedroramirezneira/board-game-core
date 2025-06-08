import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

bool isMyPiece(
  Vector2 key,
  Game<Vector2, Piece, Vector2> game,
  String? pieceType,
) {
  final piece = game.board.get(key);
  if (piece is Err) {
    return false;
  }
  final result = piece.unwrap();
  final player = game.currentPlayer;
  return switch (pieceType) {
    null => result?.color == player,
    String type => result?.color == player && result?.type == type,
  };
}
