import 'package:chess_core/chess_core.dart';
import 'package:test/test.dart';

import 'valid_castling_config.dart';

final _testGame = validCastlingConfig;

void main() {
  group("Valid castling test", () {
    test(
      "Should not be valid when being in check in intermediate steps",
      () async {
        final result = await _testGame.move(Vector2(4, 0), Vector2(6, 0));
        expect(result is Err, isTrue);
        expect(result.unwrapErr().message, "Castling is not valid");
      },
    );
  });
}
