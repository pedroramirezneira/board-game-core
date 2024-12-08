class Piece {
  final String type;
  final String color;

  const Piece({required this.type, required this.color});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Piece && type == other.type && color == other.color;
  }

  @override
  int get hashCode => Object.hash(type, color);
}
