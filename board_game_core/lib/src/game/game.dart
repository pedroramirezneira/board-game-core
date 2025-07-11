import 'package:board_game_core/board_game_core.dart';

class Game<K, V, S> {
  final String currentPlayer;
  final Board<K, V, S> board;
  final MovementProvider<K, V, S> movementProvider;
  final RuleProvider<K, V, S> ruleProvider;
  final EndProvider<K, V, S> endProvider;
  final TurnManager<K, V, S> turnManager;
  final Game<K, V, S>? previousState;
  final Input input;

  const Game({
    required this.currentPlayer,
    required this.board,
    required this.movementProvider,
    required this.ruleProvider,
    required this.endProvider,
    required this.turnManager,
    required this.previousState,
    required this.input,
  });

  Future<Result<Game<K, V, S>, GameError>> move(K from, K to) async {
    final movement = await movementProvider.execute(this, from, to);
    if (movement is Err) {
      return Err(GameError(movement.unwrapErr().message));
    }
    final state = copyWith(board: movement.unwrap(), previousState: this);
    final violation = await ruleProvider.validate(state);
    if (violation != null) {
      return Err(GameError(violation.message));
    }
    final hasEnded = await endProvider.hasEnded(state);
    if (hasEnded != null) {
      return Ok(EndedGame.fromGame(state, hasEnded));
    }
    final player = turnManager.getNextPlayer(state);
    final result = state.copyWith(currentPlayer: player, previousState: this);
    return Ok(result);
  }

  Game<K, V, S> copyWith({
    String? currentPlayer,
    Board<K, V, S>? board,
    MovementProvider<K, V, S>? movementProvider,
    RuleProvider<K, V, S>? ruleProvider,
    EndProvider<K, V, S>? endProvider,
    TurnManager<K, V, S>? turnManager,
    Game<K, V, S>? previousState,
    Input? input,
  }) {
    return Game<K, V, S>(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      board: board ?? this.board,
      movementProvider: movementProvider ?? this.movementProvider,
      ruleProvider: ruleProvider ?? this.ruleProvider,
      endProvider: endProvider ?? this.endProvider,
      turnManager: turnManager ?? this.turnManager,
      previousState: previousState ?? this.previousState,
      input: input ?? this.input,
    );
  }
}
