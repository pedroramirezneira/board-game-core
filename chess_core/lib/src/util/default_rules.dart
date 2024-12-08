import 'package:chess_core/src/chess_rule/check.dart';
import 'package:chess_core/src/chess_rule/check_mate.dart';
import 'package:chess_core/src/chess_rule/stale_mate.dart';

final defaultRules = [
  Check(),
  StaleMate(),
  CheckMate(),
];
