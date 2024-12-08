import 'package:board_game_core/src/board/board.dart';
import 'package:board_game_core/src/board/board_error.dart';
import 'package:board_game_core/src/result/result.dart';
import 'package:test/test.dart';

const testBoard = Board(initial: {
  "a": 1,
  "b": 2,
  "c": 3,
}, size: 3);

void main() {
  group('Board tests', () {
    test('Get piece', () {
      expect(testBoard.get("a").unwrap(), 1);
    });

    test('Move piece', () {
      final result = testBoard.move("a", "b").unwrap();
      expect(result.get("a").unwrap(), null);
      expect(result.get("b").unwrap(), 1);
    });

    test('Remove piece', () {
      final result = testBoard.remove("a").unwrap();
      expect(result.get("a").unwrap(), null);
    });

    test('Get all pieces', () {
      final iterator = testBoard.getAll();
      iterator.moveNext();
      final first = iterator.current;
      iterator.moveNext();
      final second = iterator.current;
      iterator.moveNext();
      final third = iterator.current;
      expect(first.first, "a");
      expect(first.second, 1);
      expect(second.first, "b");
      expect(second.second, 2);
      expect(third.first, "c");
      expect(third.second, 3);
    });

    test('Invalid move', () {
      final result = testBoard.move("a", "d");
      expect(result.runtimeType, Err<Board<String, int, int>, BoardError>);
    });

    test('No piece to move', () {
      final newBoard = testBoard.remove("c").unwrap();
      final result = newBoard.move("c", "b").runtimeType;
      expect(result, Err<Board<String, int, int>, BoardError>);
    });

    test('No piece at position', () {
      final result = testBoard.remove("d");
      expect(result.runtimeType, Err<Board<String, int, int>, BoardError>);
    });
  });
}
