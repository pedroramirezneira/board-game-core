import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class ChessRuleProvider implements RuleProvider<Vector2, Piece, Vector2> {
  const ChessRuleProvider();

  @override
  RuleViolation? validate(Game<Vector2, Piece, Vector2> game) {
    return null;
  }
}
