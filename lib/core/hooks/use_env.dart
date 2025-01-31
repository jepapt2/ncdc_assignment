import 'package:flutter_dotenv/flutter_dotenv.dart';

String getEnv(String key) {
  final value = dotenv.env[key];
  if (value == null) {
    throw Exception('環境変数「$key」が設定されていません。');
  }
  return value;
}
