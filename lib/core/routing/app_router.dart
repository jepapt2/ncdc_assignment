import 'package:go_router/go_router.dart';
import '../../features/articles/views/screens/content_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ContentListScreen(),
    ),
  ],
);
