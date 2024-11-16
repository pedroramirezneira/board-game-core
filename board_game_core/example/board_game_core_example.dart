import 'package:board_game_core/board_game_core.dart';

void main() {
  final board = Board(initial: {
    "a": 1,
    "b": 2,
    "c": 3,
  }, size: 3);
  print(board);
}
