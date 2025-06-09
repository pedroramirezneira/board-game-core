import 'package:chess_core/chess_core.dart';
import 'package:chess_core/src/chess/chess_movement_provider.dart';
import 'package:chess_core/src/chess_movement/attack_movement.dart';
import 'package:chess_core/src/chess_movement/castling.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/promotion.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/chess_movement/vector_movement.dart';
import 'package:chess_core/src/util/default_movements.dart';

class MovementProviderParser {
  Result<MovementProvider<Vector2, Piece, Vector2>, String> parse(
    ChessConfig config,
  ) {
    ChessMovementProvider provider = switch (config.use_default) {
      true => ChessMovementProvider(),
      false => ChessMovementProvider({}),
    };
    final movements = _parseMovements(config.movements ?? <MovementConfig>[]);
    if (movements == null) {
      return Err("Invalid movements");
    }
    for (final PieceConfig piece in config.pieces ?? []) {
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
      provider = provider.setMovementsForPiece(piece.type, list);
    }
    return Ok(provider);
  }

  Map<String, List<ChessMovement>>? _parseMovements(
    List<MovementConfig> config,
  ) {
    final Map<String, List<ChessMovement>> map = {};
    for (final item in config) {
      if (defaultMovements.containsKey(item.name)) return null;
      final vectors = item.vectors.map((e) => Vector2(e[0], e[1]));
      Iterable<ChessMovement> movements = switch (item.modifiers?.contains(
        "ghost",
      )) {
        true => vectors.map((v) => VectorMovement(v, limit: item.limit)),
        false => vectors.map((v) => StandardMovement(v, limit: item.limit)),
        null => vectors.map((v) => StandardMovement(v, limit: item.limit)),
      };
      for (final modifier in item.modifiers ?? <String>[]) {
        final result = switch (modifier.split("(")[0]) {
          "attack" => movements = movements.map((m) => AttackMovement(m)),
          "peaceful" => movements = movements.map((m) => PeacefulMovement(m)),
          "initial" => movements = movements.map((m) => InitialMovement(m)),
          "promotion" => movements = movements.map(
            (m) => Promotion(m, modifier.split("(")[1].replaceAll(")", "")),
          ),
          "castling" => movements = movements.map(
            (m) => Castling(
              m,
              otherType: switch (modifier.contains("(")) {
                false => null,
                true => modifier.split("(")[1].replaceAll(")", ""),
              },
            ),
          ),
          "ghost" => movements,
          String() => null,
        };
        if (result == null) return null;
      }
      map[item.name] = movements.toList();
    }
    return map;
  }
}
