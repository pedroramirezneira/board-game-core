import 'package:board_game_core/board_game_core.dart';
import 'package:json/json.dart';

@Data()
@JsonCodable()
class MovementConfig {
  final String name;
  final List<List<String>> vectors;
}
