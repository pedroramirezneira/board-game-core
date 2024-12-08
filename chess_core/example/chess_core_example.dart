import 'package:chess_core/src/chess/default_chess.dart';
import 'package:chess_core/src/data/vector2.dart';

void main() {
  // Basic example
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

  // Fool's mate
  final chess2 = defaultChess();
  final state5 = chess2.move(Vector2(x: 5, y: 1), Vector2(x: 5, y: 2)).unwrap();
  final state6 = state5.move(Vector2(x: 4, y: 6), Vector2(x: 4, y: 5)).unwrap();
  final state7 = state6.move(Vector2(x: 6, y: 1), Vector2(x: 6, y: 3)).unwrap();
  final state8 = state7.move(Vector2(x: 3, y: 7), Vector2(x: 7, y: 3)).unwrap();
  print(state8.board);
  print(state8.move(Vector2(x: 4, y: 0), Vector2(x: 5, y: 1)).unwrapErr().message);
}
