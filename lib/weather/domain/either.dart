sealed class Either<L, R> {
  const Either();
}

final class Left<L, R> extends Either<L, R> {
  const Left(this.value);

  final L value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Left<L, R> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

final class Right<L, R> extends Either<L, R> {
  const Right(this.value);

  final R value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Right<L, R> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
