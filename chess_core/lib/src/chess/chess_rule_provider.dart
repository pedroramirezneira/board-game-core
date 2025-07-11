import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_rules.dart';

class ChessRuleProvider implements RuleProvider<Vector2, Piece, Vector2> {
  const ChessRuleProvider();

  @override
  Future<RuleViolation?> validate(Game<Vector2, Piece, Vector2> game) async {
    for (final rule in defaultRules) {
      final result = await rule.validate(game);
      if (result) {
        return rule;
      }
    }
    return null;
  }
}
