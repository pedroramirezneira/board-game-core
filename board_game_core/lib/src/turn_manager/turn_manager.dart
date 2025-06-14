import 'package:board_game_core/src/game/game.dart';

abstract class TurnManager<K, V, S> {
  String getNextPlayer(Game<K, V, S> game);
}
