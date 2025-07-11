import 'dart:io';

import 'package:chess_core/chess_core.dart';

void main() async {
  var chess = defaultChess((event) async => "");
  while (true) {
    final input = stdin.readLineSync()!;
    if (input == "exit") break;
    final first = input.split("(")[1].split(")")[0].split(", ");
    final from = Vector2(int.parse(first[0]), int.parse(first[1]));
    final second = input.split("(")[2].split(")")[0].split(", ");
    final to = Vector2(int.parse(second[0]), int.parse(second[1]));
    final result = await chess.move(from, to);
    if (result is Err) {
      print(result.unwrapErr().message);
    } else {
      chess = result.unwrap();
      print(chess.board);
    }
  }
}
