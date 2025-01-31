import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/core/providers/dio_provider/dio_provider.dart';
import '../../../test_helper.dart';

class MockDio extends Mock implements Dio {}

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
  late UseContentApi useContentApi;
  late ProviderContainer container;
  late MockDio mockDio;
  late TestWidgetRef widgetRef;

  setUp(() async {
    await setupTestEnv();
    mockDio = MockDio();
    registerFallbackValue(RequestOptions(path: ''));

    container = ProviderContainer(
      overrides: [
        dioProvider.overrideWithValue(mockDio),
      ],
    );

    widgetRef = TestWidgetRef(container);
    useContentApi = UseContentApi(widgetRef);
  });

  tearDown(() {
    container.dispose();
  });

  group('UseContentApi', () {
    test('getList: 正常系 - コンテンツ一覧を取得できる', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: [
            {'id': 1, 'title': 'テスト1', 'body': '本文1'},
            {'id': 2, 'title': 'テスト2', 'body': '本文2'},
          ],
          statusCode: 200,
        ),
      );

      // Act
      final result = await useContentApi.getList();

      // Assert
      expect(result.length, equals(2));
      expect(result[0].id, equals(1));
      expect(result[0].title, equals('テスト1'));
      expect(result[1].id, equals(2));
      expect(result[1].title, equals('テスト2'));
      verify(() => mockDio.get('/content')).called(1);
    });

    test('get: 正常系 - 指定したIDのコンテンツを取得できる', () async {
      // Arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'id': 1, 'title': 'テスト', 'body': '本文'},
          statusCode: 200,
        ),
      );

      // Act
      final result = await useContentApi.get(1);

      // Assert
      expect(result.id, equals(1));
      expect(result.title, equals('テスト'));
      verify(() => mockDio.get('/content/1')).called(1);
    });

    test('create: 正常系 - コンテンツを作成できる', () async {
      // Arrange
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'id': 1, 'title': 'テスト', 'body': '本文'},
          statusCode: 200,
        ),
      );
      final dto = CreateContentDTO(title: '新規タイトル', body: '新規本文');

      // Act
      final result = await useContentApi.create(dto);

      // Assert
      expect(result.id, equals(1));
      verify(() => mockDio.post('/content', data: dto.toJson())).called(1);
    });

    test('update: 正常系 - コンテンツを更新できる', () async {
      // Arrange
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'id': 1, 'title': 'テスト', 'body': '本文'},
          statusCode: 200,
        ),
      );
      final content = Content(id: 1, title: '更新タイトル', body: '更新本文');

      // Act
      final result = await useContentApi.update(content);

      // Assert
      expect(result.id, equals(1));
      verify(() => mockDio.put('/content/1', data: content.toJson())).called(1);
    });

    test('delete: 正常系 - コンテンツを削除できる', () async {
      // Arrange
      when(() => mockDio.delete(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {'id': 1, 'title': 'テスト', 'body': '本文'},
          statusCode: 200,
        ),
      );

      // Act
      final result = await useContentApi.delete(1);

      // Assert
      expect(result.id, equals(1));
      verify(() => mockDio.delete('/content/1')).called(1);
    });
  });
}
