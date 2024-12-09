import 'package:chess_core/src/chess_end_condition/check_mate.dart';
import 'package:chess_core/src/chess_end_condition/stale_mate.dart';

const defaultEndConditions = [
  CheckMate(),
  StaleMate(),
];
