import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_end_condition/chess_end_condition.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Stalemate implements ChessEndCondition {
  final String pieceType;

  const Stalemate(this.pieceType);

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer, previousState: game);
    final fromSquares = <Vector2>[];
    final toSquares = <Vector2>[];
    final iterator = state.board.getAll();
    while (iterator.moveNext()) {
      final entry = iterator.current;
      final position = entry.first;
      final piece = entry.second;
      toSquares.add(position);
      if (piece != null && piece.color == state.currentPlayer) {
        fromSquares.add(position);
      }
    }
    for (final from in fromSquares) {
      for (final to in toSquares) {
        final result = state.movementProvider.execute(state, from, to);
        if (result is Ok) {
          final nextState = state.copyWith(
            board: result.unwrap(),
            previousState: state,
          );
          if (!Check(pieceType).validate(nextState)) {
            return false;
          }
        }
      }
    }
    return true;
  }

  @override
  String toString() => "Stalemate";
}
