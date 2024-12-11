import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_movements.dart';

const _invalidPlayerError = "The piece does not belong to the current player.";
const _invalidDestinationError =
    "A piece of the same color is in the destination.";
const _invalidMovementError = "The movement is invalid.";

class ChessMovementProvider
    implements MovementProvider<Vector2, Piece, Vector2> {
  final Map<String, List<ChessMovement>> movements = defaultMovements;
  ChessMovementProvider();
  @override
  Result<Board<Vector2, Piece, Vector2>, MovementProviderError> execute(
      Game<Vector2, Piece, Vector2> game, Vector2 from, Vector2 to) {
    final board = game.board;
    final origin = board.get(from);
    final destination = board.get(to);
    if (origin is Ok && origin.unwrap()?.color != game.currentPlayer) {
      return Err(MovementProviderError(_invalidPlayerError));
    }
    if (destination is Ok &&
        destination.unwrap()?.color == game.currentPlayer) {
      return Err(MovementProviderError(_invalidDestinationError));
    }
    final pieceMovements = movements[origin.unwrap()?.type];
    final playerMovements = game.currentPlayer == "white"
        ? pieceMovements
        : pieceMovements!.map((movement) => movement.rotate180()).toList();
    final movement = playerMovements?.firstWhere(
      (movement) => movement.execute(game, from, to) != null,
      orElse: () => _nullMovement,
    );
    if (movement == null || identical(movement, _nullMovement)) {
      return Err(MovementProviderError(_invalidMovementError));
    }
    final result = movement.execute(game, from, to);
    if (result == null) {
      return Err(MovementProviderError(_invalidMovementError));
    }
    return Ok(result);
  }
}

final _nullMovement = StandardMovement(vector: Vector2(0, 0));
