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

  int? operator /(Vector2 other) {
    final lambda = switch (null) {
      _ when other.x == 0 && other.y == 0 => 0,
      _ when other.x == 0 => y / other.y,
      _ => x / other.x,
    };
    return switch (lambda % 1 == 0) {
      false => null,
      true when lambda < 0 => null,
      true when other * lambda.toInt() != this => null,
      true => lambda.toInt(),
    };
  }

  Vector2 operator -() {
    return Vector2(-x, -y);
  }

  Vector2 normalize() {
    return switch ((x, y)) {
      (0, 0) => Vector2(0, 0),
      (0, _) => Vector2(0, y.sign),
      (_, 0) => Vector2(x.sign, 0),
      (_, _) => () {
          var a = x.abs();
          var b = y.abs();
          while (b != 0) {
            final temp = b;
            b = a % b;
            a = temp;
          }
          return Vector2(x ~/ a, y ~/ a);
        }()
    };
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
