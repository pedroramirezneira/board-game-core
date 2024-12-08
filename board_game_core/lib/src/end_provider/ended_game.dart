import 'package:board_game_core/src/board/board.dart';
import 'package:board_game_core/src/end_provider/end_condition.dart';
import 'package:board_game_core/src/end_provider/end_provider.dart';
import 'package:board_game_core/src/game/game.dart';
import 'package:board_game_core/src/game/game_error.dart';
import 'package:board_game_core/src/movement_provider/movement_provider.dart';
import 'package:board_game_core/src/result/result.dart';
import 'package:board_game_core/src/rule_provider/rule_provider.dart';
import 'package:board_game_core/src/turn_manager/turn_manager.dart';

class EndedGame<K, V, S> extends Game<K, V, S> {
  final EndCondition endCondition;

  const EndedGame({
    required super.currentPlayer,
    required super.board,
    required super.movementProvider,
    required super.ruleProvider,
    required super.endProvider,
    required super.turnManager,
    required super.previousState,
    required this.endCondition,
  });

  factory EndedGame.fromGame(Game<K, V, S> game, EndCondition endCondition) {
    return EndedGame(
      currentPlayer: game.currentPlayer,
      board: game.board,
      movementProvider: game.movementProvider,
      ruleProvider: game.ruleProvider,
      endProvider: game.endProvider,
      turnManager: game.turnManager,
      previousState: game.previousState,
      endCondition: endCondition,
    );
  }

  @override
  Result<Game<K, V, S>, GameError> move(K from, K to) {
    return Err(GameError('Game has ended'));
  }

  @override
  Game<K, V, S> copyWith({
    String? currentPlayer,
    Board<K, V, S>? board,
    MovementProvider<K, V, S>? movementProvider,
    RuleProvider<K, V, S>? ruleProvider,
    EndProvider<K, V, S>? endProvider,
    TurnManager<K, V, S>? turnManager,
    Game<K, V, S>? previousState,
  }) {
    return this;
  }
}
