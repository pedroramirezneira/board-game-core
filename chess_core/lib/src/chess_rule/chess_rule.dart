import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_violation/chess_violation.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

abstract class ChessRule {
  ChessViolation? validate(Game<Vector2, Piece, Vector2> game);
}
