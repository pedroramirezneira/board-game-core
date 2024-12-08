import 'package:board_game_core/src/end_provider/end_condition.dart';
import 'package:board_game_core/src/game/game.dart';

abstract class EndProvider<K, V, S> {
  EndCondition? hasEnded(Game<K, V, S> game);
}
