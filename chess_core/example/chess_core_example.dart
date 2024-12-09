import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';

void main() {
  // Fool's mate
  var chess = defaultChess();
  chess = chess.move(Vector2(x: 5, y: 1), Vector2(x: 5, y: 2)).unwrap();
  chess = chess.move(Vector2(x: 4, y: 6), Vector2(x: 4, y: 5)).unwrap();
  chess = chess.move(Vector2(x: 6, y: 1), Vector2(x: 6, y: 3)).unwrap();
  chess = chess.move(Vector2(x: 3, y: 7), Vector2(x: 7, y: 3)).unwrap();
  print(chess.board);
  final condition = (chess as EndedGame).endCondition.runtimeType;
  print("$condition by ${chess.currentPlayer}");
}
