import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/ai/alpha_beta.dart';

void main() {
  final time = DateTime.now();
  var chess = defaultChess();
  chess = chess.move(Vector2(4, 1), Vector2(4, 3)).unwrap();
  print(chess.board);
  print("");
  final aiMove1 = chooseBestMove(chess, 2)!;
  chess = chess.move(aiMove1.first, aiMove1.second).unwrap();
  print(chess.board);
  print("");
  chess = chess.move(Vector2(3, 1), Vector2(3, 2)).unwrap();
  print(chess.board);
  print("");
  final aiMove2 = chooseBestMove(chess, 2)!;
  chess = chess.move(aiMove2.first, aiMove2.second).unwrap();
  print(chess.board);
  print("");
  chess = chess.move(Vector2(6, 0), Vector2(5, 2)).unwrap();
  print(chess.board);
  print("");
  final aiMove3 = chooseBestMove(chess, 2)!;
  chess = chess.move(aiMove3.first, aiMove3.second).unwrap();
  print(chess.board);
  print("");
  if (chess is EndedGame) {
    final condition = (chess as EndedGame).endCondition.toString();
    print("$condition by ${chess.currentPlayer}");
  }
  print("Time: ${DateTime.now().difference(time).inMilliseconds}ms");
}
