import 'package:chess_core/src/data/vector2.dart';

const forward = [
  Vector2(x: 0, y: 1),
];

const backward = [
  Vector2(x: 0, y: -1),
];

const left = [
  Vector2(x: -1, y: 0),
];

const right = [
  Vector2(x: 1, y: 0),
];

const straight = [
  ...forward,
  ...backward,
  ...left,
  ...right,
];

const forwardLeft = [
  Vector2(x: -1, y: 1),
];

const forwardRight = [
  Vector2(x: 1, y: 1),
];

const backwardLeft = [
  Vector2(x: -1, y: -1),
];

const backwardRight = [
  Vector2(x: 1, y: -1),
];

const diagonal = [
  ...forwardLeft,
  ...forwardRight,
  ...backwardLeft,
  ...backwardRight,
];

const knight = [
  Vector2(x: 1, y: 2),
  Vector2(x: 2, y: 1),
  Vector2(x: 2, y: -1),
  Vector2(x: 1, y: -2),
  Vector2(x: -1, y: -2),
  Vector2(x: -2, y: -1),
  Vector2(x: -2, y: 1),
  Vector2(x: -1, y: 2),
];
