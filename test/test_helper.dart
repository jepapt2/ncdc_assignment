import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool _initialized = false;

Future<void> setupTestEnv() async {
  if (!_initialized) {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: '.env');
    _initialized = true;
  }
}
