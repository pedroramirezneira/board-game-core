import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

abstract class ChessRule implements RuleViolation {
  Future<bool> validate(Game<Vector2, Piece, Vector2> game);
}
