import 'package:json/json.dart';

@JsonCodable()
class MovementConfig {
  final String name;
  final List<List<String>> vectors;

  const MovementConfig({
    required this.name,
    required this.vectors,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MovementConfig &&
        name == other.name &&
        vectors == other.vectors;
  }

  @override
  int get hashCode => Object.hash(name, vectors);
}
