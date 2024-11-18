import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';

void main() {
  final chess = defaultChess();
  final state = chess.move(Vector2(x: 0, y: 1), Vector2(x: 0, y: 3)).unwrap();
  print(state.board.get(Vector2(x: 0, y: 3)).unwrap());
  final state2 = state.move(Vector2(x: 0, y: 6), Vector2(x: 0, y: 5)).unwrap();
  print(state2.board.get(Vector2(x: 0, y: 5)).unwrap());
  final state3 = state2.move(Vector2(x: 0, y: 3), Vector2(x: 0, y: 4)).unwrap();
  print(state3.board.get(Vector2(x: 0, y: 4)).unwrap());
  final state4 =
      state3.move(Vector2(x: 1, y: 1), Vector2(x: 1, y: 3)).unwrapErr();
  print(state4.message);
}
