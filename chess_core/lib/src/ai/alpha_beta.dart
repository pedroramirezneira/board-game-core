import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/ai/evaluator.dart';
import 'package:chess_core/src/ai/move_generator.dart';

Future<(Vector2, Vector2)?> chooseBestMove(
  Game<Vector2, Piece, Vector2> game,
  int depth,
) async {
  final maximizingPlayer = game.currentPlayer == 'white';
  int bestScore = maximizingPlayer ? -999999 : 999999;
  (Vector2, Vector2)? bestMove;

  for (final move in await generateLegalMoves(game)) {
    final result = await game.movementProvider.execute(game, move.$1, move.$2);
    if (result is Err) continue;

    final newGame = game.copyWith(
      board: result.unwrap(),
      currentPlayer: game.turnManager.getNextPlayer(game),
      previousState: game,
    );

    final score = await alphaBeta(
      newGame,
      depth - 1,
      -100000,
      100000,
      !maximizingPlayer,
    );

    if (maximizingPlayer && score > bestScore) {
      bestScore = score;
      bestMove = move;
    } else if (!maximizingPlayer && score < bestScore) {
      bestScore = score;
      bestMove = move;
    }
  }

  return bestMove;
}

Future<int> alphaBeta(
  Game<Vector2, Piece, Vector2> game,
  int depth,
  int alpha,
  int beta,
  bool maximizingPlayer,
) async {
  if (depth == 0 || await game.endProvider.hasEnded(game) != null) {
    return evaluate(game);
  }

  final moves = await generateLegalMoves(game);

  if (maximizingPlayer) {
    int maxEval = -999999;
    for (final move in moves) {
      final result = await game.movementProvider.execute(
        game,
        move.$1,
        move.$2,
      );
      if (result is Err) continue;

      final newGame = game.copyWith(
        board: result.unwrap(),
        currentPlayer: game.turnManager.getNextPlayer(game),
        previousState: game,
      );

      final eval = await alphaBeta(newGame, depth - 1, alpha, beta, false);
      maxEval = maxEval > eval ? maxEval : eval;
      alpha = alpha > eval ? alpha : eval;
      if (beta <= alpha) break;
    }
    return maxEval;
  } else {
    int minEval = 999999;
    for (final move in moves) {
      final result = await game.movementProvider.execute(
        game,
        move.$1,
        move.$2,
      );
      if (result is Err) continue;

      final newGame = game.copyWith(
        board: result.unwrap(),
        currentPlayer: game.turnManager.getNextPlayer(game),
        previousState: game,
      );

      final eval = await alphaBeta(newGame, depth - 1, alpha, beta, true);
      minEval = minEval < eval ? minEval : eval;
      beta = beta < eval ? beta : eval;
      if (beta <= alpha) break;
    }
    return minEval;
  }
}
