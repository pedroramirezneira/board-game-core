import 'package:board_game_core/board_game_core.dart';
import 'package:json/json.dart';

@Data()
@JsonCodable()
class PieceConfig {
  final String type;
  final List<String> movements;
}
