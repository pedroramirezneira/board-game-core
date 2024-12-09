import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_end_condition/chess_end_condition.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class StaleMate implements ChessEndCondition {
  const StaleMate();

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer);
    final iterator = state.board.getAll();
    while (iterator.moveNext() != false) {
      final from = iterator.current.first;
      final iterator2 = state.board.getAll();
      while (iterator2.moveNext() != false) {
        final to = iterator2.current.first;
        if (_handleMove(from, to, state)) return false;
      }
    }
    return true;
  }

  bool _handleMove(
    Vector2 from,
    Vector2 to,
    Game<Vector2, Piece, Vector2> game,
  ) {
    final movement = game.movementProvider.execute(game, from, to);
    if (movement is Err) {
      return false;
    }
    final state = game.copyWith(board: movement.unwrap());
    if (Check().validate(state)) {
      return false;
    }
    return true;
  }
}
