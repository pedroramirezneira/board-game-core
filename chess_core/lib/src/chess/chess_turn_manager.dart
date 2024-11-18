import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class ChessTurnManager implements TurnManager<Vector2, Piece, Vector2> {
  const ChessTurnManager();

  @override
  String getNextPlayer(Game<Vector2, Piece, Vector2> game) {
    if (game.currentPlayer == 'white') {
      return 'black';
    } else {
      return 'white';
    }
  }
}
