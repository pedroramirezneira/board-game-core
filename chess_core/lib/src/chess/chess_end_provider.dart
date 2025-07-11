import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_end_conditions.dart';

class ChessEndProvider implements EndProvider<Vector2, Piece, Vector2> {
  const ChessEndProvider();

  @override
  Future<EndCondition?> hasEnded(Game<Vector2, Piece, Vector2> game) async {
    for (final condition in defaultEndConditions) {
      final result = await condition.validate(game);
      if (result) {
        return condition;
      }
    }
    return null;
  }
}
