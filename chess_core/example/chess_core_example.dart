import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';

void main() async {
  // Fool's mate
  final time = DateTime.now();
  var chess = defaultChess((event) async => "");
  chess = (await chess.move(Vector2(5, 1), Vector2(5, 2))).unwrap();
  chess = (await chess.move(Vector2(4, 6), Vector2(4, 5))).unwrap();
  chess = (await chess.move(Vector2(6, 1), Vector2(6, 3))).unwrap();
  chess = (await chess.move(Vector2(3, 7), Vector2(7, 3))).unwrap();
  print(chess.board);
  final condition = (chess as EndedGame).endCondition.toString();
  print("$condition by ${chess.currentPlayer}");
  print("Time: ${DateTime.now().difference(time).inMilliseconds}ms");
  print("");

  // Castling
  chess = defaultChess((event) async => "");
  chess = (await chess.move(Vector2(6, 1), Vector2(6, 2))).unwrap();
  chess = (await chess.move(Vector2(7, 6), Vector2(7, 5))).unwrap();
  chess = (await chess.move(Vector2(5, 0), Vector2(6, 1))).unwrap();
  chess = (await chess.move(Vector2(7, 5), Vector2(7, 4))).unwrap();
  chess = (await chess.move(Vector2(6, 0), Vector2(5, 2))).unwrap();
  chess = (await chess.move(Vector2(7, 4), Vector2(7, 3))).unwrap();
  chess = (await chess.move(Vector2(4, 0), Vector2(6, 0))).unwrap();
  print(chess.board);
}
