import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/scan_movement.dart';
import 'package:chess_core/src/data/piece.dart';
import 'package:chess_core/src/data/vector2.dart';

class Castling implements ChessMovement {
  final ChessMovement movement;
  final String? otherType;

  const Castling(this.movement, {this.otherType});

  @override
  Board<Vector2, Piece, Vector2>? execute(
    Game<Vector2, Piece, Vector2> game,
    Vector2 from,
    Vector2 to,
  ) {
    if (movement.execute(game, from, to) == null) {
      return null;
    }
    final vector = (to - from).normalize();
    final newBoard = game.board.remove(from);
    if (newBoard is Err) {
      return null;
    }
    final newGame = game.copyWith(
      board: newBoard.unwrap(),
      currentPlayer: game.currentPlayer,
    );
    final scan = ScanMovement(vector).execute(
      newGame,
      to + vector,
      to - vector,
    );
    return switch (scan) {
      null => null,
      Board<Vector2, Piece, Vector2> board
          when otherType != null &&
              board.get(to - vector).unwrap()?.type != otherType =>
        null,
      Board<Vector2, Piece, Vector2> board => switch (board.move(from, to)) {
          Err() => null,
          Ok(value: final board) => board,
        }
    };
  }

  @override
  ChessMovement rotate180() => Castling(
        movement.rotate180(),
        otherType: otherType,
      );
}
