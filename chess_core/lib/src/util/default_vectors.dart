import 'package:chess_core/src/data/vector2.dart';

const forward = [Vector2(0, 1)];

const backward = [Vector2(0, -1)];

const left = [Vector2(-1, 0)];

const right = [Vector2(1, 0)];

const straight = [...forward, ...backward, ...left, ...right];

const forwardLeft = [Vector2(-1, 1)];

const forwardRight = [Vector2(1, 1)];

const backwardLeft = [Vector2(-1, -1)];

const backwardRight = [Vector2(1, -1)];

const diagonal = [
  ...forwardLeft,
  ...forwardRight,
  ...backwardLeft,
  ...backwardRight,
];

const knight = [
  Vector2(1, 2),
  Vector2(2, 1),
  Vector2(2, -1),
  Vector2(1, -2),
  Vector2(-1, -2),
  Vector2(-2, -1),
  Vector2(-2, 1),
  Vector2(-1, 2),
];
