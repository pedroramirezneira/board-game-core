import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/chess_rule/chess_rule.dart';
import 'package:chess_core/src/chess_rule/stale_mate.dart';
import 'package:chess_core/src/chess_violation/chess_violation.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class CheckMate implements ChessRule {
  @override
  ChessViolation? validate(Game<Vector2, Piece, Vector2> game) {
    final isInCheck = Check().validate(game);
    final isStaleMate = StaleMate().validate(game);
    if (isInCheck != null && isStaleMate != null) {
      return CheckMateViolation();
    }
    return null;
  }
}
