import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ncdc_assignment/core/hooks/use_api.dart';
import '../../test_helper.dart';

void main() {
  late MockDio mockDio;
  late ProviderContainer container;
  late UseApi useApi;

  setUp(() async {
    await setupTestEnv();
    mockDio = MockDio();
    container = createMockContainer(mockDio: mockDio);
    useApi = UseApi(TestWidgetRef(container), '/test');
  });

  tearDown(() {
    container.dispose();
  });

  group('UseApi', () {
    test('get: 正常系 - データを取得できる', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1, 'name': 'test'}),
      );

      // Act
      final result = await useApi.get<Map<String, dynamic>>(
        path: 'test',
        fromJson: (json) => json,
      );

      // Assert
      expect(result['id'], equals(1));
      expect(result['name'], equals('test'));
      verify(() => mockDio.get('/test/test')).called(1);
    });

    test('getList: 正常系 - リストを取得できる', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(
          data: [
            {'id': 1, 'name': 'test1'},
            {'id': 2, 'name': 'test2'},
          ],
        ),
      );

      // Act
      final result = await useApi.getList<Map<String, dynamic>>(
        path: 'test',
        fromJson: (json) => json,
      );

      // Assert
      expect(result.length, equals(2));
      expect(result[0]['id'], equals(1));
      expect(result[0]['name'], equals('test1'));
      expect(result[1]['id'], equals(2));
      expect(result[1]['name'], equals('test2'));
      verify(() => mockDio.get('/test/test')).called(1);
    });

    test('post: 正常系 - データを作成できる', () async {
      // Arrange
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1, 'name': 'test'}),
      );
      final data = {'name': 'test'};

      // Act
      final result = await useApi.post<Map<String, dynamic>>(
        path: 'test',
        data: data,
        fromJson: (json) => json,
      );

      // Assert
      expect(result['id'], equals(1));
      expect(result['name'], equals('test'));
      verify(() => mockDio.post('/test/test', data: data)).called(1);
    });

    test('put: 正常系 - データを更新できる', () async {
      // Arrange
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1, 'name': 'updated'}),
      );
      final data = {'name': 'updated'};

      // Act
      final result = await useApi.put<Map<String, dynamic>>(
        path: 'test',
        data: data,
        fromJson: (json) => json,
      );

      // Assert
      expect(result['id'], equals(1));
      expect(result['name'], equals('updated'));
      verify(() => mockDio.put('/test/test', data: data)).called(1);
    });

    test('delete: 正常系 - データを削除できる', () async {
      // Arrange
      when(() => mockDio.delete(any())).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1, 'name': 'deleted'}),
      );

      final result = await useApi.delete<Map<String, dynamic>>(
        path: 'test',
        fromJson: (json) => json,
      );

      // Assert
      expect(result?['id'], equals(1));
      expect(result?['name'], equals('deleted'));
      verify(() => mockDio.delete('/test/test')).called(1);
    });

    test('delete: 異常系 - 削除に失敗した場合はthrow', () async {
      // Arrange
      when(() => mockDio.delete(any())).thenThrow(
        Exception('削除エラー'),
      );

      // Act & Assert
      expect(
        () => useApi.delete(path: 'test'),
        throwsA(isA<Exception>()),
      );
    });

    test('get: 異常系 - レスポンスがnullの場合、エラーをスローする', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: null),
      );

      // Act & Assert
      expect(
        () async => await useApi.get<Map<String, dynamic>>(
          path: 'item',
          fromJson: (json) => json,
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('サーバーエラーが発生しました'),
          ),
        ),
      );
    });

    test('get: 異常系 - DioExceptionが発生した場合、適切なエラーメッセージに変換される', () async {
      // Arrange
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/test/item'),
        ),
      );

      // Act & Assert
      expect(
        () async => await useApi.get<Map<String, dynamic>>(
          path: 'item',
          fromJson: (json) => json,
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('通信タイムアウトが発生しました'),
          ),
        ),
      );
    });

    test('getList: 正常系 - レスポンスがnullの場合、空リストを返す', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: null),
      );

      // Act
      final result = await useApi.getList<Map<String, dynamic>>(
        path: 'items',
        fromJson: (json) => json,
      );

      // Assert
      expect(result, isEmpty);
    });

    test('_constructFullPath: パスが正しく構築される', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1}),
      );

      // Act
      await useApi.get<Map<String, dynamic>>(
        path: 'path/with/multiple/segments',
        fromJson: (json) => json,
      );

      // Assert
      verify(() => mockDio.get('/test/path/with/multiple/segments')).called(1);
    });

    test('_constructFullPath: パスがnullの場合、basePathのみが使用される', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: {'id': 1}),
      );

      // Act
      await useApi.get<Map<String, dynamic>>(
        path: null,
        fromJson: (json) => json,
      );

      // Assert
      verify(() => mockDio.get('/test')).called(1);
    });
  });
}
