import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

final Map<Vector2, Piece?> defaultChessBoard = {
  for (var x = 0; x < 8; x++)
    for (var y = 0; y < 8; y++)
      if (y == 0)
        Vector2(x: x, y: y): Piece(type: _firstRow[x]!, color: "white")
      else if (y == 1)
        Vector2(x: x, y: y): Piece(type: "pawn", color: "white")
      else if (y == 6)
        Vector2(x: x, y: y): Piece(type: "pawn", color: "black")
      else if (y == 7)
        Vector2(x: x, y: y): Piece(type: _firstRow[x]!, color: "black")
      else
        Vector2(x: x, y: y): null
};

const _firstRow = {
  0: "rook",
  1: "knight",
  2: "bishop",
  3: "queen",
  4: "king",
  5: "bishop",
  6: "knight",
  7: "rook",
};
