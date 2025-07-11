import 'package:board_game_core/board_game_core.dart';
import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/ai/alpha_beta.dart';

void main() async {
  final time = DateTime.now();
  var chess = defaultChess((event) async => "");
  chess = (await chess.move(Vector2(4, 1), Vector2(4, 3))).unwrap();
  print(chess.board);
  print("");
  final aiMove1 = await chooseBestMove(chess, 2);
  chess = (await chess.move(aiMove1!.$1, aiMove1.$2)).unwrap();
  print(chess.board);
  print("");
  chess = (await chess.move(Vector2(3, 1), Vector2(3, 2))).unwrap();
  print(chess.board);
  print("");
  final aiMove2 = await chooseBestMove(chess, 2);
  chess = (await chess.move(aiMove2!.$1, aiMove2.$2)).unwrap();
  print(chess.board);
  print("");
  chess = (await chess.move(Vector2(6, 0), Vector2(5, 2))).unwrap();
  print(chess.board);
  print("");
  final aiMove3 = await chooseBestMove(chess, 2);
  chess = (await chess.move(aiMove3!.$1, aiMove3.$2)).unwrap();
  print(chess.board);
  print("");
  if (chess is EndedGame) {
    final condition = (chess as EndedGame).endCondition.toString();
    print("$condition by ${chess.currentPlayer}");
  }
  print("Time: ${DateTime.now().difference(time).inMilliseconds}ms");
}
