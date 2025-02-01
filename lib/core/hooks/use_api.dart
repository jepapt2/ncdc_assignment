import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/hooks/utils/json_util.dart';
import '../providers/dio_provider/dio_provider.dart';

class UseApi {
  final String basePath;
  final Dio dio;

  UseApi._(this.basePath, this.dio);

  factory UseApi(Ref ref, String basePath) {
    return UseApi._(basePath, ref.read(dioProvider));
  }

  String _constructFullPath(String? path) {
    if (path == null) {
      return basePath;
    }
    final sanitizedPath = Uri(path: path).toString();
    return '$basePath/$sanitizedPath';
  }

  Future<T> get<T>({
    String? path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(_constructFullPath(path),
          queryParameters: queryParameters);
      final data = response.data;

      if (data == null) {
        throw _responseEmptyError(path);
      }

      return fromJson(data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  Future<List<T>> getList<T>({
    String? path,
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(_constructFullPath(path),
          queryParameters: queryParameters);
      final data = response.data;

      if (data == null) {
        return [];
      }

      if (data is! List) {
        throw _responseEmptyError(path);
      }

      for (final item in data) {
        if (item is! Map<String, dynamic>) {
          throw _responseEmptyError(path);
        }
      }

      return fromJsonList(
        data.cast<Map<String, dynamic>>(),
        fromJson,
      );
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  Future<T> post<T>({
    String? path,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(_constructFullPath(path), data: data);
      final responseData = response.data;

      if (responseData == null) {
        throw _responseEmptyError(path);
      }

      return fromJson(responseData as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  Future<T> put<T>({
    String? path,
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.put(_constructFullPath(path), data: data);
      final responseData = response.data;

      if (responseData == null) {
        throw _responseEmptyError(path);
      }

      return fromJson(responseData as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  Future<T?> delete<T>({
    String? path,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await dio.delete(_constructFullPath(path));
      final responseData = response.data;
      if (fromJson != null && responseData != null) {
        return fromJson(responseData as Map<String, dynamic>);
      }
      return null;
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  static Exception _mapDioErrorToException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('通信タイムアウトが発生しました');
      case DioExceptionType.badResponse:
        return Exception('サーバーエラーが発生しました: ${e.response?.statusCode}');
      case DioExceptionType.connectionError:
        return Exception('通信エラーが発生しました');
      default:
        return Exception(e.message);
    }
  }

  DioException _responseEmptyError(String? path) {
    return DioException(
      requestOptions: RequestOptions(path: _constructFullPath(path)),
      type: DioExceptionType.badResponse,
    );
  }
}
