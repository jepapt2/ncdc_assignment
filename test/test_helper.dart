import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ncdc_assignment/core/providers/dio_provider/dio_provider.dart';

class MockDio extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

// ProviderContainerをWidgetRefとして扱うためのラッパー
class TestWidgetRef implements Ref {
  @override
  final ProviderContainer container;

  TestWidgetRef(this.container);

  @override
  T read<T>(ProviderListenable<T> provider) => container.read(provider);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// モックデータ
Response getMockResponse({
  dynamic data,
  int statusCode = 200,
}) {
  return Response(
    requestOptions: RequestOptions(path: ''),
    data: data,
    statusCode: statusCode,
  );
}

// テスト環境のセットアップ
bool _initialized = false;

Future<void> setupTestEnv() async {
  if (!_initialized) {
    TestWidgetsFlutterBinding.ensureInitialized();
    try {
      await dotenv.load(fileName: '.env');
      _initialized = true;
    } catch (e) {
      print('Warning: .env file could not be loaded: $e');
      rethrow;
    }
  }
}

// モックコンテナの作成
ProviderContainer createMockContainer({required MockDio mockDio}) {
  return ProviderContainer(
    overrides: [
      dioProvider.overrideWithValue(mockDio),
    ],
  );
}
