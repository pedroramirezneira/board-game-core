import 'package:board_game_core/board_game_core.dart';
import 'package:test/test.dart';
import '../game/game_test.dart';

class _MyProvider implements RuleProvider<String, int, int> {
  const _MyProvider();
  @override
  RuleViolation? validate(Game<String, int, int> game) {
    if (game.currentPlayer == "black") {
      return RuleViolation("Invalid player");
    }
    return null;
  }
}

const testRuleProvider = _MyProvider();

void main() {
  group('Rule provider tests', () {
    test('Valid game', () {
      final result = testRuleProvider.validate(testGame);
      expect(result, null);
    });

    test('Invalid game', () {
      final game = testGame.copyWith(currentPlayer: "black");
      final result = testRuleProvider.validate(game);
      expect(result.runtimeType, RuleViolation);
    });
  });
}
