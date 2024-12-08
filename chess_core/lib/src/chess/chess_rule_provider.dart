import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_rules.dart';

class ChessRuleProvider implements RuleProvider<Vector2, Piece, Vector2> {
  const ChessRuleProvider();

  @override
  RuleViolation? validate(Game<Vector2, Piece, Vector2> game) {
    for (final rule in defaultRules) {
      final result = rule.validate(game);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
