import 'package:chess_core/chess_core.dart';

class ConfigParser {
  Result<Game<Vector2, Piece, Vector2>, String> parse(
    ChessConfig config,
    Input input,
  ) {
    final game = defaultChess(input);
    final provider = MovementProviderParser().parse(config);
    if (provider is Err) {
      return Err(provider.unwrapErr());
    }
    final board = BoardParser().parse(config);
    if (board is Err) {
      return Err(board.unwrapErr());
    }
    return Ok(
      game.copyWith(board: board.unwrap(), movementProvider: provider.unwrap()),
    );
  }
}
