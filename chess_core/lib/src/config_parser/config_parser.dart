import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/chess_movement_provider.dart';
import 'package:chess_core/src/config/chess_config.dart';

class ConfigParser {
  MovementProvider parse(ChessConfig config) {
    return ChessMovementProvider();
  }
}
