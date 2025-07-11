import 'package:board_game_core/board_game_core.dart';
import 'package:test/test.dart';
import '../game/game_test.dart';

class _MyProvider implements RuleProvider<String, int, int> {
  const _MyProvider();
  @override
  Future<RuleViolation?> validate(Game<String, int, int> game) async {
    if (game.currentPlayer == "black") {
      return RuleViolation("Invalid player");
    }
    return null;
  }
}

const testRuleProvider = _MyProvider();

void main() {
  group('Rule provider tests', () {
    test('Valid game', () async {
      final result = await testRuleProvider.validate(testGame);
      expect(result, null);
    });

    test('Invalid game', () async {
      final game = testGame.copyWith(currentPlayer: "black");
      final result = await testRuleProvider.validate(game);
      expect(result.runtimeType, RuleViolation);
    });
  });
}
