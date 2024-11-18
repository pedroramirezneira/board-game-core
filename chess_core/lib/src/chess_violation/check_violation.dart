import 'package:board_game_core/board_game_core.dart';

abstract class ChessViolation implements RuleViolation {}

class CheckViolation implements ChessViolation {
  const CheckViolation();
  @override
  String get message => "The king is in check.";
}

class CheckMateViolation implements ChessViolation {
  const CheckMateViolation();
  @override
  String get message => "The king is in checkmate.";
}

class StaleMateViolation implements ChessViolation {
  const StaleMateViolation();
  @override
  String get message => "The game is in stalemate.";
}
