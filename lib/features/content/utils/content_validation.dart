import 'package:ncdc_assignment/core/utils/toast_helper.dart';
import 'package:ncdc_assignment/core/utils/validation_helper.dart';

class ContentValidation {
  static String? errorCheckToast(String? message) {
    if (message == null) return null;
    showToast(message);
    return message;
  }

  static String? validateTitle(String? value) {
    return errorCheckToast(ValidationHelper.combine([
      () => ValidationHelper.required(value, name: 'タイトル'),
      () => ValidationHelper.maxLength(value, 100, name: 'タイトル'),
    ]));
  }

  static String? validateBody(String? value) {
    return errorCheckToast(ValidationHelper.combine([
      () => ValidationHelper.maxLength(value, 2000, name: '本文'),
    ]));
  }
}
