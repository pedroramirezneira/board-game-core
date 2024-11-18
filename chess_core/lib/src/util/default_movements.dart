import 'package:chess_core/src/chess_movement/attack_movement.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_vectors.dart';

const Map<String, List<ChessMovement>> defaultMovements = {
  "king": [...straight, ...diagonal]
      .map((e) => StandardMovement(vector: Vector2(x: e.x, y: e.y), limit: 1))
      .toList(),
  "queen": [...straight, ...diagonal]
      .map((e) => StandardMovement(vector: Vector2(x: e.x, y: e.y)))
      .toList(),
  "rook": straight
      .map((e) => StandardMovement(vector: Vector2(x: e.x, y: e.y)))
      .toList(),
  "bishop": diagonal
      .map((e) => StandardMovement(vector: Vector2(x: e.x, y: e.y)))
      .toList(),
  "knight": knight
      .map((e) => StandardMovement(vector: Vector2(x: e.x, y: e.y), limit: 1))
      .toList(),
  "pawn": forward
      .map<ChessMovement>((e) => PeacefulMovement(
          StandardMovement(vector: Vector2(x: e.x, y: e.y), limit: 1)))
      .toList()
    ..addAll([...forwardLeft, ...forwardRight].map((e) => AttackMovement(
        StandardMovement(vector: Vector2(x: e.x, y: e.y), limit: 1))))
    ..addAll([...forward].map((e) => InitialMovement(PeacefulMovement(
        StandardMovement(vector: Vector2(x: e.x, y: e.y), limit: 2)))))
};
