import 'package:board_game_core/board_game_core.dart';
import 'package:test/test.dart';

import '../board/board_test.dart';
import '../game/game_test.dart';

class _MyProvider implements MovementProvider<String, int, int> {
  const _MyProvider();
  @override
  Result<Board<String, int, int>, MovementProviderError> execute(
    Game<String, int, int> game,
    String from,
    String to,
  ) {
    if (from == "b" && to == "c") {
      return Err(MovementProviderError("Invalid move"));
    }
    final board = game.board.move(from, to);
    if (board is Err) {
      return Err(MovementProviderError("Invalid key"));
    }
    return Ok(board.unwrap());
  }
}

const testMovementProvider = _MyProvider();

void main() {
  group('Movement provider tests', () {
    test('Valid move', () {
      final result = testMovementProvider.execute(testGame, "a", "b");
      expect(result.unwrap().get("a").runtimeType, Err<int, BoardError>);
      expect(result.unwrap().get("b").unwrap(), 1);
    });

    test('Invalid move', () {
      final result = testMovementProvider.execute(testGame, "b", "c");
      expect(result.runtimeType,
          Err<Board<String, int, int>, MovementProviderError>);
      expect(testBoard.get("b").unwrap(), 2);
    });

    test('Invalid key', () {
      final result = testMovementProvider.execute(testGame, "d", "c");
      expect(result.runtimeType,
          Err<Board<String, int, int>, MovementProviderError>);
    });
  });
}
