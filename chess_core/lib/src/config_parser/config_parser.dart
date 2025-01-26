import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/config_parser/board_parser.dart';
import 'package:chess_core/src/config_parser/movement_provider_parser.dart';

class ConfigParser {
  Result<Game<Vector2, Piece, Vector2>, String> parse(ChessConfig config) {
    final game = defaultChess();
    final provider = MovementProviderParser().parse(config);
    if (provider is Err) {
      return Err(provider.unwrapErr());
    }
    final board = BoardParser().parse(config);
    if (board is Err) {
      return Err(board.unwrapErr());
    }
    return Ok(game.copyWith(
      board: board.unwrap(),
      movementProvider: provider.unwrap(),
    ));
  }
}
