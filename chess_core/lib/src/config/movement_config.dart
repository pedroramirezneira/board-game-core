import 'package:json/json.dart';

@JsonCodable()
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
}
