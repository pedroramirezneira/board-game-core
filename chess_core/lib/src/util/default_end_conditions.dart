import 'package:chess_core/src/chess_end_condition/checkmate.dart';
import 'package:chess_core/src/chess_end_condition/stalemate.dart';

const defaultEndConditions = [
  Checkmate("king"),
  Stalemate("king"),
];
