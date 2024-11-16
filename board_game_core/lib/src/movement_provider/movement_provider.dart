import 'package:board_game_core/board_game_core.dart';

abstract class MovementProvider<K, V, S> {
  Result<Board<K, V, S>, MovementProviderError> execute(
      Game<K, V, S> game, K from, K to);
}
