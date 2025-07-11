import 'package:board_game_core/src/input/event.dart';

typedef Input = Future<String> Function(Event event);
