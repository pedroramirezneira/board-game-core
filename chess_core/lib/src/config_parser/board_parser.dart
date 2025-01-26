import 'package:chess_core/chess_core.dart';

class BoardParser {
  Result<Board<Vector2, Piece, Vector2>, String> parse(ChessConfig config) {
    if (config.board == null) {
      return Ok(defaultChess().board);
    }
    final arrangement = _parseArrangement(config.board!);
    if (arrangement == null) {
      return Err("Invalid arrangement");
    }
    final board = Board(
      initial: arrangement,
      size: Vector2(
        config.board!.width,
        config.board!.height,
      ),
      toString: (board) {
        final buffer = StringBuffer();
        for (int i = 0; i < 8; i++) {
          for (int j = 0; j < 8; j++) {
            final piece = board.get(Vector2(j, i));
            buffer.write("|${piece.unwrap()?.type}".padRight(7));
            if (j == 7 && i == 7) {
              buffer.write("|");
            } else if (j == 7) {
              buffer.writeln("|");
            }
          }
        }
        return buffer.toString();
      },
    );
    return Ok(board);
  }

  Map<Vector2, Piece?>? _parseArrangement(BoardConfig config) {
    final Map<Vector2, Piece?> map = {};
    for (int i = 0; i < config.height; i++) {
      for (int j = 0; j < config.width; j++) {
        final key = "$j $i";
        if (!config.arrangement.containsKey(key)) {
          map[Vector2(j, i)] = null;
          continue;
        }
        final value = config.arrangement[key]!;
        final color = value.split(" ")[0];
        final type = value.split(" ")[1];
        map[Vector2(j, i)] = Piece(
          type: type,
          color: color,
        );
      }
    }
    return map;
  }
}
