class Vector2 {
  final int x;
  final int y;

  const Vector2({required this.x, required this.y});

  Vector2 operator +(Vector2 other) {
    return Vector2(x: x + other.x, y: y + other.y);
  }

  Vector2 operator *(int other) {
    return Vector2(x: x * other, y: y * other);
  }

  Vector2 operator -(Vector2 other) {
    return Vector2(x: x - other.x, y: y - other.y);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Vector2 && x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() {
    return "Vector2(x: $x, y: $y)";
  }
}
