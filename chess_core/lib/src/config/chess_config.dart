// ignore_for_file: non_constant_identifier_names

import 'package:chess_core/src/config/board_config.dart';
import 'package:chess_core/src/config/default_config.dart';
import 'package:chess_core/src/config/movement_config.dart';
import 'package:chess_core/src/config/piece_config.dart';

class ChessConfig {
  final bool use_default;
  final BoardConfig board;
  final List<MovementConfig>? movements;
  final List<PieceConfig>? pieces;

  const ChessConfig({
    required this.use_default,
    required this.board,
    this.movements,
    this.pieces,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChessConfig &&
        use_default == other.use_default &&
        board == other.board &&
        movements == other.movements &&
        pieces == other.pieces;
  }

  @override
  int get hashCode => Object.hash(use_default, board, movements, pieces);

  factory ChessConfig.standard() {
    return ChessConfig.fromJson(defaultConfig);
  }

  factory ChessConfig.fromJson(Map<String, dynamic> json) {
    final movements = json['movements'] as List<dynamic>?;
    final pieces = json['pieces'] as List<dynamic>?;

    return ChessConfig(
      use_default: json['use_default'],
      board: BoardConfig.fromJson(json['board']),
      movements: movements?.map((e) => MovementConfig.fromJson(e)).toList(),
      pieces: pieces?.map((e) => PieceConfig.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'use_default': use_default,
      'board': board.toJson(),
      'movements': movements?.map((x) => x.toJson()).toList(),
      'pieces': pieces?.map((x) => x.toJson()).toList(),
    };
  }
}
