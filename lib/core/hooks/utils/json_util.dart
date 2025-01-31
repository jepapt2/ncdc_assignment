List<T> fromJsonList<T>(
  List<Map<String, dynamic>> jsonList,
  T Function(Map<String, dynamic> json) fromJson,
) {
  return jsonList
      .map((dynamic item) => fromJson(item as Map<String, dynamic>))
      .toList();
}
