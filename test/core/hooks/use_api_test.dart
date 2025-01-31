import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ncdc_assignment/core/hooks/use_api.dart';
import 'package:ncdc_assignment/core/providers/dio_provider/dio_provider.dart';
import '../../test_helper.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

// ProviderContainerをWidgetRefとして扱うためのラッパー
class TestWidgetRef implements WidgetRef {
  final ProviderContainer container;

  TestWidgetRef(this.container);

  @override
  T read<T>(ProviderListenable<T> provider) => container.read(provider);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late MockDio mockDio;
  late ProviderContainer container;
  late UseApi useApi;
  const basePath = '/test';

  setUp(() async {
    await setupTestEnv();
    mockDio = MockDio();
    registerFallbackValue(RequestOptions(path: ''));
    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(mockDio),
      ],
    );
    useApi = UseApi(TestWidgetRef(container), basePath);
  });

  tearDown(() {
    container.dispose();
  });

  group('UseApi', () {
    test('get: 正常系 - データを取得できる', () async {
      // Arrange
      final mockResponse = MockResponse();
      final expectedData = {'id': 1, 'name': 'test'};
      when(() => mockResponse.data).thenReturn(expectedData);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.get<Map<String, dynamic>>(
        path: 'item',
        fromJson: (json) => json,
      );

      // Assert
      expect(result, equals(expectedData));
      verify(() => mockDio.get('/test/item')).called(1);
    });

    test('get: 異常系 - レスポンスがnullの場合、エラーをスローする', () async {
      // Arrange
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn(null);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => useApi.get<Map<String, dynamic>>(
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
        () => useApi.get<Map<String, dynamic>>(
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

    test('getList: 正常系 - リストデータを取得できる', () async {
      // Arrange
      final mockResponse = MockResponse();
      final expectedData = [
        {'id': 1, 'name': 'test1'},
        {'id': 2, 'name': 'test2'},
      ];
      when(() => mockResponse.data).thenReturn(expectedData);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.getList<Map<String, dynamic>>(
        path: 'items',
        fromJson: (json) => json,
      );

      // Assert
      expect(result, equals(expectedData));
      verify(() => mockDio.get('/test/items')).called(1);
    });

    test('getList: 正常系 - レスポンスがnullの場合、空リストを返す', () async {
      // Arrange
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn(null);
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.getList<Map<String, dynamic>>(
        path: 'items',
        fromJson: (json) => json,
      );

      // Assert
      expect(result, isEmpty);
    });

    test('post: 正常系 - データを作成できる', () async {
      // Arrange
      final mockResponse = MockResponse();
      final requestData = {'name': 'test'};
      final expectedData = {'id': 1, 'name': 'test'};
      when(() => mockResponse.data).thenReturn(expectedData);
      when(() => mockDio.post(any(), data: any(named: 'data')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.post<Map<String, dynamic>>(
        path: 'item',
        data: requestData,
        fromJson: (json) => json,
      );

      // Assert
      expect(result, equals(expectedData));
      verify(() => mockDio.post('/test/item', data: requestData)).called(1);
    });

    test('put: 正常系 - データを更新できる', () async {
      // Arrange
      final mockResponse = MockResponse();
      final requestData = {'name': 'updated'};
      final expectedData = {'id': 1, 'name': 'updated'};
      when(() => mockResponse.data).thenReturn(expectedData);
      when(() => mockDio.put(any(), data: any(named: 'data')))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.put<Map<String, dynamic>>(
        path: 'item/1',
        data: requestData,
        fromJson: (json) => json,
      );

      // Assert
      expect(result, equals(expectedData));
      verify(() => mockDio.put('/test/item/1', data: requestData)).called(1);
    });

    test('delete: 正常系 - データを削除できる', () async {
      // Arrange
      final mockResponse = MockResponse();
      final expectedData = {'success': true};
      when(() => mockResponse.data).thenReturn(expectedData);
      when(() => mockDio.delete(any())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await useApi.delete<Map<String, dynamic>>(
        path: 'item/1',
        fromJson: (json) => json,
      );

      // Assert
      expect(result, equals(expectedData));
      verify(() => mockDio.delete('/test/item/1')).called(1);
    });

    test('_constructFullPath: パスが正しく構築される', () async {
      // Arrange
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn({'id': 1});
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

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
      final mockResponse = MockResponse();
      when(() => mockResponse.data).thenReturn({'id': 1});
      when(() => mockDio.get(any())).thenAnswer((_) async => mockResponse);

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
