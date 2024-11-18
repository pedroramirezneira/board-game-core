import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_rule/chess_rule.dart';
import 'package:chess_core/src/chess_violation/check_violation.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Check implements ChessRule {
  @override
  ChessViolation? validate(Game<Vector2, Piece, Vector2> game) {
    return null;
  }
}
