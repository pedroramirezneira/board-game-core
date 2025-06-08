import 'package:chess_core/src/chess_movement/attack_movement.dart';
import 'package:chess_core/src/chess_movement/castling.dart';
import 'package:chess_core/src/chess_movement/chess_movement.dart';
import 'package:chess_core/src/chess_movement/en_passant.dart';
import 'package:chess_core/src/chess_movement/initial_movement.dart';
import 'package:chess_core/src/chess_movement/peaceful_movement.dart';
import 'package:chess_core/src/chess_movement/promotion.dart';
import 'package:chess_core/src/chess_movement/standard_movement.dart';
import 'package:chess_core/src/chess_movement/valid_movement.dart';
import 'package:chess_core/src/data/vector2.dart';
import 'package:chess_core/src/util/default_vectors.dart';

final Map<String, List<ChessMovement>> defaultMovements = {
  "king":
      [...straight, ...diagonal]
          .map<ChessMovement>(
            (e) => StandardMovement(Vector2(e.x, e.y), limit: 1),
          )
          .toList()
        ..addAll([
          InitialMovement(
            Castling(
              StandardMovement(Vector2(2, 0), limit: 1),
              otherType: "rook",
              onPieceFound: InitialMovement(ValidMovement()),
            ),
          ),
          InitialMovement(
            Castling(
              StandardMovement(Vector2(-2, 0), limit: 1),
              otherType: "rook",
              onPieceFound: InitialMovement(ValidMovement()),
            ),
          ),
        ]),
  "queen": [
    ...straight,
    ...diagonal,
  ].map((e) => StandardMovement(Vector2(e.x, e.y))).toList(),
  "rook": straight.map((e) => StandardMovement(Vector2(e.x, e.y))).toList(),
  "bishop": diagonal.map((e) => StandardMovement(Vector2(e.x, e.y))).toList(),
  "knight": knight
      .map((e) => StandardMovement(Vector2(e.x, e.y), limit: 1))
      .toList(),
  "pawn":
      forward
          .map<ChessMovement>(
            (e) => Promotion(
              PeacefulMovement(StandardMovement(Vector2(e.x, e.y), limit: 1)),
              "queen",
            ),
          )
          .toList()
        ..addAll(
          [...forwardLeft, ...forwardRight].map(
            (e) => Promotion(
              PeacefulMovement(
                EnPassant(
                  StandardMovement(Vector2(e.x, e.y), limit: 1),
                  otherType: "pawn",
                ),
              ),
              "queen",
            ),
          ),
        )
        ..addAll(
          [...forwardLeft, ...forwardRight].map(
            (e) => Promotion(
              AttackMovement(StandardMovement(Vector2(e.x, e.y), limit: 1)),
              "queen",
            ),
          ),
        )
        ..addAll(
          forward.map(
            (e) => Promotion(
              InitialMovement(
                PeacefulMovement(StandardMovement(Vector2(e.x, e.y), limit: 2)),
              ),
              "queen",
            ),
          ),
        ),
};
