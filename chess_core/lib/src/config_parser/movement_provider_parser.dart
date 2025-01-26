import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess/chess_movement_provider.dart';
import 'package:chess_core/src/chess_movement/attack_movement.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/config/chess_config.dart';
import 'package:chess_core/src/config/movement_config.dart';
import 'package:chess_core/src/util/default_movements.dart';

class MovementProviderParser {
  Result<MovementProvider<Vector2, Piece, Vector2>, String> parse(
      ChessConfig config) {
    final provider = ChessMovementProvider();
    if (!config.use_default) {
      provider.movements.clear();
    }
    final movements =
        config.movements == null ? null : _parseMovements(config.movements!);
    if (movements == null) {
      return Err("Invalid movements");
    }
    if (config.pieces == null) {
      return Ok(provider);
    }
    for (final piece in config.pieces!) {
      final List<ChessMovement> list = [];
      for (final movement in piece.movements) {
        if (defaultMovements.containsKey(movement)) {
          list.addAll(defaultMovements[movement]!);
          continue;
        }
        if (!movements.containsKey(movement)) {
          return Err("Invalid movement: $movement");
        }
        list.addAll(movements[movement]!);
      }
      provider.movements[piece.type] = list;
    }
    return Ok(provider);
  }

  Map<String, List<ChessMovement>>? _parseMovements(
      List<MovementConfig> config) {
    final Map<String, List<ChessMovement>> map = {};
    for (final item in config) {
      if (defaultMovements.containsKey(item.name)) return null;
      final vectors = item.vectors.map((e) => Vector2(e[0], e[1]));
      Iterable<ChessMovement> movements =
          vectors.map((v) => StandardMovement(vector: v, limit: item.limit));
      for (final modifier in item.modifiers) {
        final result = switch (modifier) {
          "attack" => movements = movements.map((m) => AttackMovement(m)),
          "peaceful" => movements = movements.map((m) => PeacefulMovement(m)),
          "initial" => movements = movements.map((m) => InitialMovement(m)),
          _ => null
        };
        if (result == null) return null;
      }
      map[item.name] = movements.toList();
    }
    return map;
  }
}
