import 'package:dio/dio.dart';
import '../api/api_client.dart';

class UseApi {
  final String basePath;

  const UseApi(this.basePath);

  String _constructFullPath(String? path) =>
      path != null ? '$basePath/$path' : basePath;

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
        throw _createResponseError(path);
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
        throw _createResponseError(path);
      }

      return data
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
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
        throw _createResponseError(path);
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
        throw _createResponseError(path);
      }

      return fromJson(responseData as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _mapDioErrorToException(e);
    }
  }

  Future<T> delete<T>({
    String? path,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.delete(_constructFullPath(path));
      final responseData = response.data;

      if (responseData == null) {
        throw _createResponseError(path);
      }

      return fromJson(responseData as Map<String, dynamic>);
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

  DioException _createResponseError(String? path) {
    return DioException(
      requestOptions: RequestOptions(path: _constructFullPath(path)),
      type: DioExceptionType.badResponse,
    );
  }
}
