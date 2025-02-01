class ValidationHelper {
  static String? required(String? value, {required String name}) {
    if (value == null || value.isEmpty) {
      return '$nameを入力してください';
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength,
      {required String name}) {
    if (value != null && value.length > maxLength) {
      return '$nameは$maxLength文字以内で入力してください';
    }
    return null;
  }

  static String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final error = validator();
      if (error != null) {
        return error;
      }
    }
    return null;
  }
}
