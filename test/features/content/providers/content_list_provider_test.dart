import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ncdc_assignment/features/content/models/content/content.dart';
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

  group('ContentListProvider', () {
    test('build: 正常系 - コンテンツ一覧を取得できる', () async {
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );

      final contentState = container.read(contentListProvider);
      expect(contentState.isLoading, true);

      await container.read(contentListProvider.future);
      final result = container.read(contentListProvider).value;

      expect(result?.length, equals(2));
      expect(result?[0].id, equals(1));
      expect(result?[0].title, equals('テストタイトル1'));
      verify(() => mockDio.get('/content')).called(1);
    });

    test('create: 正常系 - コンテンツを作成できる', () async {
      // 初期データ取得
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);

      // 作成
      when(() => mockDio.post('/content', data: any(named: 'data'))).thenAnswer(
        (_) async => getMockResponse(
          data: ContentFactory.create(
            title: '新規タイトル',
            body: '新規本文',
          ).toJson(),
        ),
      );

      final dto = CreateContentDTO(
        title: '新規タイトル',
        body: '新規本文',
      );

      final result =
          await container.read(contentListProvider.notifier).create(dto);

      expect(result?.title, equals('新規タイトル'));
      expect(result?.body, equals('新規本文'));
      verify(() => mockDio.post('/content', data: any(named: 'data')))
          .called(1);

      // リストに追加されていることを確認
      final list = container.read(contentListProvider).value;
      expect(list?.length, equals(3));
      expect(list?.last.title, equals('新規タイトル'));
    });

    test('delete: 正常系 - コンテンツを削除できる', () async {
      // 初期データ取得
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);

      // 削除
      when(() => mockDio.delete('/content/1')).thenAnswer(
        (_) async => getMockResponse(data: null),
      );

      final content = ContentFactory.create();
      final result =
          await container.read(contentListProvider.notifier).delete(content);

      expect(result, isTrue);
      verify(() => mockDio.delete('/content/1')).called(1);

      // リストから削除されていることを確認
      final list = container.read(contentListProvider).value;
      expect(list?.length, equals(1));
      expect(list?.any((e) => e.id == content.id), isFalse);
    });

    test('updateState: 正常系 - コンテンツを更新できる', () async {
      // 初期データ取得
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);

      final updatedContent = ContentFactory.create(
        title: '更新後タイトル',
        body: '更新後本文',
      );

      container.read(contentListProvider.notifier).updateState(updatedContent);

      final list = container.read(contentListProvider).value;
      expect(list?.length, equals(2));
      expect(list?.firstWhere((e) => e.id == updatedContent.id).title,
          equals('更新後タイトル'));
    });

    test('create: 異常系 - 作成に失敗した場合はnullを返す', () async {
      // 初期データ取得
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);

      // 作成失敗
      when(() => mockDio.post('/content', data: any(named: 'data'))).thenThrow(
        Exception('作成エラー'),
      );

      final dto = CreateContentDTO(title: '新規タイトル');
      final result =
          await container.read(contentListProvider.notifier).create(dto);

      expect(result, isNull);

      // リストが変更されていないことを確認
      final list = container.read(contentListProvider).value;
      expect(list?.length, equals(2));
    });

    test('delete: 異常系 - 削除に失敗した場合はfalseを返す', () async {
      when(() => mockDio.get('/content')).thenAnswer(
        (_) async => getMockResponse(data: ContentFactory.createJsonList()),
      );
      await container.read(contentListProvider.future);
      when(() => mockDio.delete('/content/1')).thenThrow(
        Exception('削除エラー'),
      );

      final content = ContentFactory.create();
      final result =
          await container.read(contentListProvider.notifier).delete(content);

      expect(result, isFalse);

      final list = container.read(contentListProvider).value;
      expect(list?.length, equals(2));
      expect(list?.any((e) => e.id == content.id), isTrue);
    });
  });
}
