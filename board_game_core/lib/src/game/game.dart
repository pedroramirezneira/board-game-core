import 'package:board_game_core/board_game_core.dart';

class Game<K, V, S> {
  final String currentPlayer;
  final Board<K, V, S> board;
  final MovementProvider<K, V, S> movementProvider;
  final RuleProvider<K, V, S> ruleProvider;
  final TurnManager<K, V, S> turnManager;
  final Game<K, V, S>? previousState;

  const Game({
    required this.currentPlayer,
    required this.board,
    required this.movementProvider,
    required this.ruleProvider,
    required this.turnManager,
    required this.previousState,
  });

  Result<Game<K, V, S>, GameError> move(K from, K to) {
    final movement = movementProvider.execute(this, from, to);
    if (movement is Err) {
      return Err(GameError(movement.unwrapErr().message));
    }
    final state = copyWith(board: movement.unwrap(), previousState: this);
    final violation = ruleProvider.validate(state);
    if (violation != null) {
      return Err(GameError(violation.message));
    }
    final nextPlayer = turnManager.getNextPlayer(state);
    final result = state.copyWith(currentPlayer: nextPlayer);
    return Ok(result);
  }

  Game<K, V, S> copyWith({
    String? currentPlayer,
    Board<K, V, S>? board,
    MovementProvider<K, V, S>? movementProvider,
    RuleProvider<K, V, S>? ruleProvider,
    TurnManager<K, V, S>? turnManager,
    Game<K, V, S>? previousState,
  }) {
    return Game<K, V, S>(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      board: board ?? this.board,
      movementProvider: movementProvider ?? this.movementProvider,
      ruleProvider: ruleProvider ?? this.ruleProvider,
      turnManager: turnManager ?? this.turnManager,
      previousState: previousState,
    );
  }
}
