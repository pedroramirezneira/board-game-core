class Vector2 {
  final int x;
  final int y;

  const Vector2(this.x, this.y);

  Vector2 operator +(Vector2 other) {
    return Vector2(x + other.x, y + other.y);
  }

  Vector2 operator *(int other) {
    return Vector2(x * other, y * other);
  }

  Vector2 operator -(Vector2 other) {
    return Vector2(x - other.x, y - other.y);
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
