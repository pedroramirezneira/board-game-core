import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_end_condition/chess_end_condition.dart';
import 'package:chess_core/src/chess_end_condition/stalemate.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Checkmate implements ChessEndCondition {
  final String pieceType;

  const Checkmate(this.pieceType);

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer, previousState: game);
    return Check(pieceType).validate(state) &&
        Stalemate(pieceType).validate(game);
  }

  @override
  String toString() => "Checkmate";
}
