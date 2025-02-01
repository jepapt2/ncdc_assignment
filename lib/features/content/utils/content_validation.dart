import 'package:ncdc_assignment/core/utils/validation_helper.dart';

class ContentValidation {
  static String? validateTitle(String? value) {
    return ValidationHelper.combine([
      () => ValidationHelper.required(value, name: 'タイトル'),
      () => ValidationHelper.maxLength(value, 100, name: 'タイトル'),
    ]);
  }
}
