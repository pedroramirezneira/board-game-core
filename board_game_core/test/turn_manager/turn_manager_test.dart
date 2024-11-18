import 'package:board_game_core/board_game_core.dart';
import 'package:test/test.dart';
import '../game/game_test.dart';

class _MyProvider implements TurnManager<String, int, int> {
  const _MyProvider();
  @override
  String getNextPlayer(Game<String, int, int> game) {
    return "black";
  }
}

const testTurnManager = _MyProvider();

void main() {
  group('Turn manager tests', () {
    test('Valid player change', () {
      expect(testGame.currentPlayer, "white");
      final result = testTurnManager.getNextPlayer(testGame);
      expect(result, "black");
    });
  });
}
