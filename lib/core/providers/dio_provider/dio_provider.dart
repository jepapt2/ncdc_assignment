import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../hooks/use_env.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(BaseOptions(
    baseUrl: getEnv('API_BASE_URL'),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 5),
  ))
    // リクエストとレスポンスの内容をログ出力する
    ..interceptors.add(LogInterceptor(
      requestBody: true, // リクエストボディをログ出力
      responseBody: true, // レスポンスボディをログ出力
    ));
}
