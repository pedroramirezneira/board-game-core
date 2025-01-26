import 'dart:convert';
import 'dart:io';
import 'package:chess_core/chess_core.dart';

Future<void> main(List<String> args) async {
  final string =
      await File("./lib/src/config/default_chess.json").readAsString();
  final decoded = json.decode(string);
  final config = ChessConfig.fromJson(decoded);
  var chess = ConfigParser().parse(config).unwrap();
  chess = chess.move(Vector2(2, 0), Vector2(3, 3)).unwrap();
  print(chess.board);
  print("");
  chess = chess.move(Vector2(0, 7), Vector2(1, 7)).unwrap();
  print(chess.move(Vector2(3, 3), Vector2(4, 6)).unwrapErr().message);
  print("");
  chess = chess.move(Vector2(3, 3), Vector2(5, 4)).unwrap();
  print(chess.board);
}
