import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/chess_rule/chess_rule.dart';
import 'package:chess_core/src/chess_rule/get_last_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class ValidCastling implements ChessRule {
  final String pieceType;

  const ValidCastling(this.pieceType);

  @override
  String get message => "Castling is not valid";

  @override
  bool validate(Game<Vector2, Piece, Vector2> game) {
    final previousState = game.previousState;
    if (previousState == null) {
      return false;
    }
    final pieceMovement = getLastMovement(game, pieceType);
    if (pieceMovement == null) {
      return false;
    }
    final (from, to, piece) = pieceMovement;
    final delta = to - from;
    final vector = delta.normalize();
    final lambda = delta / vector;
    if (lambda == null) {
      return false;
    }
    final castlingPosition = to - vector;
    final castlingPiece = game.board.get(castlingPosition);
    if (castlingPiece is Err) {
      return false;
    }
    if (identical(
      castlingPiece.unwrap(),
      previousState.board.get(castlingPosition).unwrap(),
    )) {
      return false;
    }
    if (identical(previousState.board.get(castlingPosition).unwrap(), piece)) {
      return false;
    }
    final check = Check(pieceType);
    for (var i = 0; i < lambda; i++) {
      final next = from + vector * i;
      final step = previousState.board.move(from, next);
      if (step is Err) {
        return false;
      }
      final newGame = game.copyWith(
        board: step.unwrap(),
        previousState: previousState,
      );
      final isValid = check.validate(newGame);
      if (isValid) {
        return true;
      }
    }
    return false;
  }
}
