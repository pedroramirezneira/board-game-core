import 'package:chess_core/src/data/vector2.dart';

final forward = [
  Vector2(x: 0, y: 1),
];

final backward = [
  Vector2(x: 0, y: -1),
];

final left = [
  Vector2(x: -1, y: 0),
];

final right = [
  Vector2(x: 1, y: 0),
];

final straight = [
  ...forward,
  ...backward,
  ...left,
  ...right,
];

final forwardLeft = [
  Vector2(x: -1, y: 1),
];

final forwardRight = [
  Vector2(x: 1, y: 1),
];

final backwardLeft = [
  Vector2(x: -1, y: -1),
];

final backwardRight = [
  Vector2(x: 1, y: -1),
];

final diagonal = [
  ...forwardLeft,
  ...forwardRight,
  ...backwardLeft,
  ...backwardRight,
];

final knight = [
  Vector2(x: 1, y: 2),
  Vector2(x: 2, y: 1),
  Vector2(x: 2, y: -1),
  Vector2(x: 1, y: -2),
  Vector2(x: -1, y: -2),
  Vector2(x: -2, y: -1),
  Vector2(x: -2, y: 1),
  Vector2(x: -1, y: 2),
];
