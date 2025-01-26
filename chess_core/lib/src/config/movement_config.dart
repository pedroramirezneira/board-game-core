class MovementConfig {
  final String name;
  final List<String> modifiers;
  final List<List<int>> vectors;
  final int? limit;

  const MovementConfig({
    required this.name,
    required this.modifiers,
    required this.vectors,
    this.limit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MovementConfig &&
        name == other.name &&
        modifiers == other.modifiers &&
        vectors == other.vectors &&
        limit == other.limit;
  }

  @override
  int get hashCode => Object.hash(name, modifiers, vectors);

  factory MovementConfig.fromJson(Map<String, dynamic> json) {
    final modifiers = json['modifiers'] as List<dynamic>;
    final vectors = (json['vectors'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).cast<int>())
        .toList();
    return MovementConfig(
      name: json['name'],
      modifiers: modifiers.cast(),
      vectors: vectors.cast(),
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modifiers': modifiers,
      'vectors': vectors,
      'limit': limit,
    };
  }
}
