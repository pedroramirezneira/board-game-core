import 'package:board_game_core/src/game/game.dart';

abstract class TurnManager<K, V, S> {
  Game<K, V, S> onTurnEnd(Game<K, V, S> game);
}
