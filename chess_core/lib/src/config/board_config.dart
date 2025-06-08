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

  factory BoardConfig.fromJson(Map<String, dynamic> json) {
    final arrangement = json['arrangement'] as Map<String, dynamic>;
    return BoardConfig(
      height: json['height'],
      width: json['width'],
      arrangement: arrangement.cast(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'height': height, 'width': width, 'arrangement': arrangement};
  }
}
