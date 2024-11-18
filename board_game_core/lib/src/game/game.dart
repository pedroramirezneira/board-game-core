import 'package:board_game_core/board_game_core.dart';

class Game<K, V, S> {
  final String currentPlayer;
  final Board<K, V, S> board;
  final MovementProvider<K, V, S> _movementProvider;
  final RuleProvider<K, V, S> _ruleProvider;
  final TurnManager<K, V, S> _turnManager;
  final Game<K, V, S>? previousState;

  const Game({
    required this.currentPlayer,
    required this.board,
    required MovementProvider<K, V, S> movementProvider,
    required RuleProvider<K, V, S> ruleProvider,
    required TurnManager<K, V, S> turnManager,
    required this.previousState,
  })  : _movementProvider = movementProvider,
        _ruleProvider = ruleProvider,
        _turnManager = turnManager;

  Result<Game<K, V, S>, GameError> move(K from, K to) {
    final movement = _movementProvider.execute(this, from, to);
    if (movement is Err) {
      return Err(GameError(movement.unwrapErr().message));
    }
    final state = copyWith(board: movement.unwrap(), previousState: this);
    final violation = _ruleProvider.validate(state);
    if (violation != null) {
      return Err(GameError(violation.message));
    }
    final nextPlayer = _turnManager.getNextPlayer(state);
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
      movementProvider: movementProvider ?? _movementProvider,
      ruleProvider: ruleProvider ?? _ruleProvider,
      turnManager: turnManager ?? _turnManager,
      previousState: previousState,
    );
  }
}
