import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_end_condition/chess_end_condition.dart';
import 'package:chess_core/src/chess_end_condition/stale_mate.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class CheckMate implements ChessEndCondition {
  const CheckMate();

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer);
    final isInCheck = Check().validate(state);
    final isStaleMate = StaleMate().validate(game);
    if (isInCheck && isStaleMate) {
      return true;
    }
    return false;
  }
}
