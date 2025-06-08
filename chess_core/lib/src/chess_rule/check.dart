import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_rule/chess_rule.dart';
import 'package:chess_core/src/chess_rule/handle_move.dart';
import 'package:chess_core/src/chess_rule/is_my_piece.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Check implements ChessRule {
  final String pieceType;

  const Check(this.pieceType);

  @override
  String get message => "The $pieceType is in check";

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    var isInCheck = false;
    var pieceCount = 0;
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer, previousState: game);
    final iterator = state.board.getAll();
    while (iterator.moveNext() != false) {
      final from = iterator.current.first;
      if (isMyPiece(from, game, pieceType)) {
        pieceCount++;
      }
      final iterator2 = state.board.getAll();
      while (iterator2.moveNext() != false) {
        if (pieceCount > 1) {
          return false;
        }
        final (to) = iterator2.current.first;
        if (handleMove(from, to, state, pieceType)) {
          isInCheck = true;
        }
      }
    }
    return pieceCount == 1 && isInCheck;
  }
}
