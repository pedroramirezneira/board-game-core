import 'package:board_game_core/src/board/board_error.dart';
import 'package:board_game_core/src/result/result.dart';

const _invalidMovementError =
    "The movement is invalid: the specified positions are out of bounds.";
const _noPieceToMoveError =
    "There is no piece at the specified starting position to move.";
const _noPieceAtPositionError = "No piece exists at the specified position.";

class Board<K, V, S> {
  final Map<K, V?> _map;
  final S size;
  final String Function(Board<K, V, S> board)? _toString;

  const Board({
    required Map<K, V?> initial,
    required this.size,
    String Function(Board<K, V, S> board)? toString,
  })  : _map = initial,
        _toString = toString;

  Result<Board<K, V, S>, BoardError> move(K from, K to) {
    if (!_map.containsKey(from) || !_map.containsKey(to)) {
      return Err(BoardError(_invalidMovementError));
    }
    if (_map[from] == null) {
      return Err(BoardError(_noPieceToMoveError));
    }
    final map = Map<K, V?>.from(_map)
      ..[from] = null
      ..[to] = _map[from];
    return Ok(Board(initial: map, size: size, toString: _toString));
  }

  Result<V?, BoardError> get(K key) {
    if (!_map.containsKey(key)) {
      return Err(BoardError(_noPieceAtPositionError));
    }
    return Ok(_map[key]);
  }

  Iterator<(K, V?)> getAll() {
    return _map.entries.map((e) => (e.key, e.value)).iterator;
  }

  Result<Board<K, V, S>, BoardError> remove(K position) {
    if (!_map.containsKey(position) || _map[position] == null) {
      return Err(BoardError(_noPieceAtPositionError));
    }
    final map = Map<K, V?>.from(_map);
    map[position] = null;
    return Ok(Board(initial: map, size: size, toString: _toString));
  }

  Result<Board<K, V, S>, BoardError> put(K position, V value) {
    if (!_map.containsKey(position)) {
      return Err(BoardError(_invalidMovementError));
    }
    final map = Map<K, V?>.from(_map);
    map[position] = value;
    return Ok(Board(initial: map, size: size, toString: _toString));
  }

  @override
  String toString() {
    return _toString != null
        ? _toString(this)
        : "Board(map: $_map, size: $size)";
  }
}
