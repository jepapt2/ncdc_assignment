List<T> fromJsonList<T>(
  List<Map<String, dynamic>> jsonList,
  T Function(Map<String, dynamic> json) fromJson,
) {
  return jsonList
      .map((dynamic item) => fromJson(item as Map<String, dynamic>))
      .toList();
}

List<Map<String, dynamic>> toJsonList<T>(
  List<T> list,
  Map<String, dynamic> Function(T item) toJson,
) {
  return list.map((item) => toJson(item)).toList();
}
