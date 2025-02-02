T rethrowApiFunction<T>(T Function() func) {
  try {
    return func();
  } catch (e) {
    rethrow;
  }
}
