import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
import 'package:ncdc_assignment/features/content/providers/content_detail_provider/content_detail_provider.dart';
import 'package:ncdc_assignment/features/content/providers/content_list_provider/content_list_provider.dart';
import '../../../test_helper.dart';
import '../../../factories/content_factory.dart';

void main() {
  late MockDio mockDio;
  late ProviderContainer container;

  setUp(() async {
    await setupTestEnv();
    mockDio = MockDio();
    container = createMockContainer(mockDio: mockDio);
  });

  tearDown(() {
    container.dispose();
  });

  group('ContentDetailProvider', () {
    test('build: 正常系 - コンテンツを取得できる', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );

      final contentState = container.read(contentDetailProvider(1));
      expect(contentState.isLoading, true);

      await container.read(contentDetailProvider(1).future);
      final result = container.read(contentDetailProvider(1)).value;

      expect(result?.id, equals(1));
      expect(result?.title, equals('テストタイトル'));
      verify(() => mockDio.get('/content/1')).called(1);
    });

    test('updateContent: 正常系 - コンテンツを更新できる', () async {
      // contentListProviderの初期データ読み込み
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);

      // 初期データ取得
      when(() => mockDio.get('/content/1')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );
      await container.read(contentDetailProvider(1).future);

      // 更新
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(
          data: ContentFactory.create(
            title: '更新後タイトル',
            body: '更新後本文',
          ).toJson(),
        ),
      );

      final dto = CreateContentDTO(
        title: '更新後タイトル',
        body: '更新後本文',
      );

      final result = await container
          .read(contentDetailProvider(1).notifier)
          .updateContent(dto);

      expect(result?.title, equals('更新後タイトル'));
      expect(result?.body, equals('更新後本文'));
      verify(() => mockDio.put('/content/1', data: any(named: 'data')))
          .called(1);
    });

    test('updateContent: 異常系 - 更新に失敗した場合はnullを返す', () async {
      // 初期データ取得
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.create().toJson()),
      );
      await container.read(contentDetailProvider(1).future);

      // 更新失敗
      when(() => mockDio.put(any(), data: any(named: 'data'))).thenThrow(
        Exception('更新エラー'),
      );

      final dto = CreateContentDTO(title: '更新後タイトル');
      final result = await container
          .read(contentDetailProvider(1).notifier)
          .updateContent(dto);

      expect(result, isNull);
    });
  });
}
