import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess_movement/attack_movement.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/chess_movement/valid_movement.dart';
import 'package:test/test.dart';

final _testGame = defaultChess();

void main() {
  group("Chess movement tests", () {
    test("Standard movement test", () {
      final movement = StandardMovement(vector: Vector2(0, 1), limit: 1);
      final result = movement.execute(_testGame, Vector2(5, 1), Vector2(5, 2));
      final invalid = movement.execute(_testGame, Vector2(5, 1), Vector2(5, 3));
      expect(result, isNotNull);
      expect(invalid, isNull);
    });

    test("Initial movement test", () {
      final movement = InitialMovement(ValidMovement());
      final result = movement.execute(_testGame, Vector2(5, 1), Vector2(5, 2));
      expect(result, isNotNull);
    });

    test("Peaceful movement test", () {
      final movement = PeacefulMovement(ValidMovement());
      final result = movement.execute(_testGame, Vector2(5, 1), Vector2(5, 2));
      expect(result, isNotNull);
    });

    test("Attack movement", () {
      final movement = AttackMovement(ValidMovement());
      final result = movement.execute(_testGame, Vector2(5, 1), Vector2(5, 2));
      expect(result, isNull);
    });

    test("En passant test", () {
      var chess = defaultChess();
      chess = chess.move(Vector2(0, 1), Vector2(0, 3)).unwrap();
      chess = chess.move(Vector2(7, 6), Vector2(7, 5)).unwrap();
      chess = chess.move(Vector2(0, 3), Vector2(0, 4)).unwrap();
      chess = chess.move(Vector2(1, 6), Vector2(1, 4)).unwrap();
      chess = chess.move(Vector2(0, 4), Vector2(1, 5)).unwrap();
      expect(chess.board.get(Vector2(1, 4)).unwrap(), isNull);
    });
  });
}
