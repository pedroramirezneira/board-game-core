import 'package:board_game_core/board_game_core.dart';
import 'package:board_game_core/src/turn_manager/turn_manager.dart';
import 'package:test/test.dart';
import '../game/game_test.dart';

class _MyProvider implements TurnManager<String, int, int> {
  const _MyProvider();
  @override
  Game<String, int, int> onTurnEnd(Game<String, int, int> game) {
    return game.copyWith(currentPlayer: "black");
  }
}

const testTurnManager = _MyProvider();

void main() {
  group('Turn manager tests', () {
    test('Valid player change', () {
      expect(testGame.currentPlayer, "white");
      final result = testTurnManager.onTurnEnd(testGame);
      expect(result.currentPlayer, "black");
    });
  });
}
