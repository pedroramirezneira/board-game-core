// ignore_for_file: non_constant_identifier_names

import 'package:chess_core/src/config/movement_config.dart';
import 'package:chess_core/src/config/piece_config.dart';
import 'package:json/json.dart';

@JsonCodable()
class ChessConfig {
  final bool use_default;
  final String board_size;
  final List<MovementConfig> movements;
  final List<PieceConfig> pieces;

  const ChessConfig({
    required this.use_default,
    required this.board_size,
    required this.movements,
    required this.pieces,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChessConfig &&
        use_default == other.use_default &&
        board_size == other.board_size &&
        movements == other.movements &&
        pieces == other.pieces;
  }

  @override
  int get hashCode => Object.hash(use_default, board_size, movements, pieces);
}
