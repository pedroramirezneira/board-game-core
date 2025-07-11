import 'package:chess_core/chess_core.dart';

const _json = {
  "use_default": true,
  "board": {
    "height": 8,
    "width": 8,
    "arrangement": {
      "4 0": "white king",
      "7 0": "white rook",
      "4 7": "black king",
      "5 7": "black queen",
      "4 6": "black queen",
    },
  },
};

final validCastlingConfig = ConfigParser()
    .parse(ChessConfig.fromJson(_json), (event) async => "")
    .unwrap();
