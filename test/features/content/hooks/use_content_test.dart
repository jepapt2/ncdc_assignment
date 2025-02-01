import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:ncdc_assignment/features/content/hooks/use_content_api.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import '../../../test_helper.dart';
import '../../../factories/content_factory.dart';

void main() {
  late MockDio mockDio;
  late ProviderContainer container;
  late UseContentApi useContentApi;

  setUp(() async {
    await setupTestEnv();
    mockDio = MockDio();
    container = createMockContainer(mockDio: mockDio);
    useContentApi = UseContentApi(TestWidgetRef(container));
  });

  tearDown(() {
    container.dispose();
  });

  group('UseContentApi', () {
    test('getList: 正常系 - コンテンツ一覧を取得できる', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );

      final result = await useContentApi.getList();

      expect(result.length, equals(2));
      expect(result[0].id, equals(1));
      expect(result[0].title, equals('テストタイトル1'));
      expect(result[1].id, equals(2));
      expect(result[1].title, equals('テストタイトル2'));
      verify(() => mockDio.get('/content')).called(1);
    });

    test('get: 正常系 - 指定したIDのコンテンツを取得できる', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );

      final result = await useContentApi.get(1);

      expect(result.id, equals(1));
      expect(result.title, equals('テストタイトル'));
      verify(() => mockDio.get('/content/1')).called(1);
    });

    test('create: 正常系 - コンテンツを作成できる', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );
      final dto = ContentFactory.createDTO();

      final result = await useContentApi.create(dto);

      expect(result.id, equals(1));
      verify(() => mockDio.post('/content', data: dto.toJson())).called(1);
    });

    test('update: 正常系 - コンテンツを更新できる', () async {
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );
      final content = ContentFactory.create();

      final result = await useContentApi.update(content);

      expect(result.id, equals(1));
      verify(() => mockDio.put('/content/1', data: content.toJson())).called(1);
    });

    test('delete: 正常系 - コンテンツを削除できる', () async {
      when(() => mockDio.delete(any())).thenAnswer(
        (_) async => getMockResponse(data: null),
      );

      await expectLater(
        () => useContentApi.delete(1),
        returnsNormally,
      );

      verify(() => mockDio.delete('/content/1')).called(1);
    });
  });
}
