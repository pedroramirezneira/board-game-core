class Pair<T, E> {
  final T first;
  final E second;
  const Pair(this.first, this.second);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pair<T, E> &&
        other.first == first &&
        other.second == second;
  }

  @override
  int get hashCode => Object.hash(first, second);
}
