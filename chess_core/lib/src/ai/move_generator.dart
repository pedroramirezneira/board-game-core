import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:board_game_core/board_game_core.dart';

Future<List<(Vector2, Vector2)>> generateLegalMoves(
  Game<Vector2, Piece, Vector2> game,
) async {
  final moves = <(Vector2, Vector2)>[];
  final squares = <Vector2>[];
  final iterator = game.board.getAll();
  while (iterator.moveNext()) {
    squares.add(iterator.current.$1);
  }
  for (final from in squares) {
    final result = game.board.get(from);
    if (result is Err) continue;
    final piece = result.unwrap();
    if (piece == null || piece.color != game.currentPlayer) continue;
    for (final to in squares) {
      final result = await game.movementProvider.execute(game, from, to);
      if (result is Ok) {
        final tempGame = game.copyWith(board: result.unwrap());
        if (await game.ruleProvider.validate(tempGame) == null) {
          moves.add((from, to));
        }
      }
    }
  }

  return moves;
}
