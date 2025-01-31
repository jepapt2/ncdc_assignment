import 'package:dio/dio.dart';
import '../hooks/use_env.dart';

final dio = Dio(BaseOptions(
  baseUrl: getEnv('API_BASE_URL'),
  contentType: 'application/json',
));
