import 'package:board_game_core/src/game/game.dart';
import 'package:board_game_core/src/rule_provider/rule_violation.dart';

abstract class RuleProvider<K, V, S> {
  RuleViolation? validate(Game<K, V, S> game);
}
