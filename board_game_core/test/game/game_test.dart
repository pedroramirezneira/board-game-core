import 'package:board_game_core/board_game_core.dart';
import 'package:test/test.dart';

import '../board/board_test.dart';
import '../movement_provider/movement_provider_test.dart';
import '../rule_provider/rule_provider_test.dart';
import '../turn_manager/turn_manager_test.dart';

const testGame = Game(
  currentPlayer: "white",
  board: testBoard,
  movementProvider: testMovementProvider,
  ruleProvider: testRuleProvider,
  turnManager: testTurnManager,
  previousState: null,
);

void main() {
  group('Board tests', () {
    final map = {
      "a": "x",
      "b": "y",
      "c": "z",
    };
    final board = Board(initial: map, size: 3);

    test('Get piece', () {
      expect(board.get("a").unwrap(), "x");
    });

    test('Move piece', () {
      final newBoard = board.move("a", "b").unwrap();
      expect(newBoard.get("a").unwrap(), null);
      expect(newBoard.get("b").unwrap(), "x");
    });

    test('Remove piece', () {
      final newBoard = board.remove("a").unwrap();
      expect(newBoard.get("a").unwrap(), null);
    });

    test('Get all pieces', () {
      final iterator = board.getAll();
      iterator.moveNext();
      final first = iterator.current;
      iterator.moveNext();
      final second = iterator.current;
      iterator.moveNext();
      final third = iterator.current;
      expect(first.first, "a");
      expect(first.second, "x");
      expect(second.first, "b");
      expect(second.second, "y");
      expect(third.first, "c");
      expect(third.second, "z");
    });

    test('Invalid move', () {
      final newBoard = board.move("a", "d");
      expect(newBoard.runtimeType, Err<Board<String, String, int>, BoardError>);
    });

    test('No piece to move', () {
      final newBoard = board.remove("c").unwrap();
      final result = newBoard.move("c", "b").runtimeType;
      expect(result, Err<Board<String, String, int>, BoardError>);
    });

    test('No piece at position', () {
      final newBoard = board.remove("d");
      expect(newBoard.runtimeType, Err<Board<String, String, int>, BoardError>);
    });
  });
}
