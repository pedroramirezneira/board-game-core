import 'package:board_game_core/src/end_provider/end_condition.dart';
import 'package:board_game_core/src/end_provider/end_provider.dart';
import 'package:board_game_core/src/game/game.dart';
import 'package:test/test.dart';

import '../game/game_test.dart';

class _WinCondition extends EndCondition {}

class _MyProvider implements EndProvider<String, int, int> {
  const _MyProvider();

  @override
  Future<EndCondition?> hasEnded(Game<String, int, int> game) async {
    if (game.currentPlayer == "black") {
      return _WinCondition();
    }
    return null;
  }
}

const testEndProvider = _MyProvider();

void main() {
  group('End provider tests', () {
    test('Not ended game', () async {
      final result = await testEndProvider.hasEnded(testGame);
      expect(result, null);
    });

    test('Ended game', () async {
      final game = testGame.copyWith(currentPlayer: "black");
      final result = await testEndProvider.hasEnded(game);
      expect(result.runtimeType, _WinCondition);
    });
  });
}
