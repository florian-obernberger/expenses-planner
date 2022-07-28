S? nullableFunction<S, T>(S Function(T t) f, T? value) {
  return value == null ? null : f(value);
}
