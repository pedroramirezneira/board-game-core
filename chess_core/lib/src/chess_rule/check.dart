import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_rule/chess_rule.dart';
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
    var kingCount = 0;
    final nextPlayer = game.turnManager.getNextPlayer(game);
    final state = game.copyWith(currentPlayer: nextPlayer, previousState: game);
    final iterator = state.board.getAll();
    while (iterator.moveNext() != false) {
      final from = iterator.current.first;
      if (_isMyKing(from, game)) {
        kingCount++;
      }
      final iterator2 = state.board.getAll();
      while (iterator2.moveNext() != false) {
        if (kingCount > 1) {
          return false;
        }
        final to = iterator2.current.first;
        if (_handleMove(from, to, state)) {
          isInCheck = true;
        }
      }
    }
    return kingCount == 1 && isInCheck;
  }

  bool _isMyKing(Vector2 key, Game<Vector2, Piece, Vector2> game) {
    final piece = game.board.get(key);
    if (piece is Err) {
      return false;
    }
    final result = piece.unwrap();
    final player = game.currentPlayer;
    return result?.color == player && result?.type == pieceType;
  }

  bool _handleMove(
    Vector2 from,
    Vector2 to,
    Game<Vector2, Piece, Vector2> game,
  ) {
    final piece = game.board.get(to);
    if (piece is Err || piece.unwrap()?.type != pieceType) {
      return false;
    }
    if (piece.unwrap()?.color != game.previousState?.currentPlayer) {
      return false;
    }
    final movement = game.movementProvider.execute(game, from, to);
    if (movement is Err) {
      return false;
    }
    return true;
  }
}
