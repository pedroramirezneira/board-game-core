// ignore_for_file: non_constant_identifier_names

import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/config/movement_config.dart';
import 'package:chess_core/src/config/piece_config.dart';
import 'package:json/json.dart';

@Data()
@JsonCodable()
class ChessConfig {
  final bool use_default;
  final String board_size;
  final List<MovementConfig> movements;
  final List<PieceConfig> pieces;
}
