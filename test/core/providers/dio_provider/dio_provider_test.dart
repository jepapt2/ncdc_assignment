import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ncdc_assignment/core/providers/dio_provider/dio_provider.dart';
import 'package:ncdc_assignment/core/hooks/use_env.dart';
import '../../../test_helper.dart';

void main() async {
  late ProviderContainer container;

  setUp(() async {
    await setupTestEnv();
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('dioProvider', () {
    test('正しい設定でDioインスタンスが生成される', () {
      final dio = container.read(dioProvider);

      expect(dio.options.baseUrl, equals(getEnv('API_BASE_URL')));
      expect(dio.options.headers['Content-Type'], equals('application/json'));
      expect(
        dio.options.headers['Accept'],
        equals('application/json'),
      );
    });

    test('同じインスタンスが再利用される', () {
      final dio1 = container.read(dioProvider);
      final dio2 = container.read(dioProvider);

      expect(identical(dio1, dio2), isTrue);
    });
  });
}
