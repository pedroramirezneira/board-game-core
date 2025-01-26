class PieceConfig {
  final String type;
  final List<String> movements;

  const PieceConfig({
    required this.type,
    required this.movements,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PieceConfig &&
        type == other.type &&
        movements == other.movements;
  }

  @override
  int get hashCode => Object.hash(type, movements);

  factory PieceConfig.fromJson(Map<String, dynamic> json) {
    final movements = json['movements'] as List<dynamic>;
    return PieceConfig(
      type: json['type'],
      movements: movements.cast(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'movements': movements,
    };
  }
}
