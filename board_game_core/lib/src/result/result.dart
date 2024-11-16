sealed class Result<T, E> {
  const Result();
  T unwrap();
  E unwrapErr();
}

class Ok<T, E> implements Result<T, E> {
  final T value;
  const Ok(this.value);

  @override
  T unwrap() {
    return value;
  }

  @override
  E unwrapErr() {
    throw Error();
  }
}

class Err<T, E> extends Result<T, E> {
  final E error;
  const Err(this.error);

  @override
  T unwrap() {
    throw Error();
  }

  @override
  E unwrapErr() {
    return error;
  }
}
