import 'package:board_game_core/board_game_core.dart';

@Data()
class Vector2 {
  final int x;
  final int y;

  Vector2 operator +(Vector2 other) {
    return Vector2(x: x + other.x, y: y + other.y);
  }

  Vector2 operator -(Vector2 other) {
    return Vector2(x: x - other.x, y: y - other.y);
  }
}
