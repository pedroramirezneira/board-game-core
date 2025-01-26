import 'package:json/json.dart';

@JsonCodable()
class BoardConfig {
  final int height;
  final int width;
  final Map<String, String> arrangement;

  const BoardConfig({
    required this.height,
    required this.width,
    required this.arrangement,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BoardConfig &&
        height == other.height &&
        width == other.width &&
        arrangement == other.arrangement;
  }

  @override
  int get hashCode => Object.hash(height, width, arrangement);
}
