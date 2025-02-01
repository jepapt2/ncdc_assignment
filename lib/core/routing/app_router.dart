import 'package:go_router/go_router.dart';
import 'package:ncdc_assignment/features/content/screens/content_detail_screen.dart';
import '../../features/content/views/screens/content_list_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const ContentListScreen(),
      routes: [
        GoRoute(
          path: 'content/:id',
          name: 'contentDetail',
          builder: (context, state) {
            final id = int.parse(state.pathParameters['id'] ?? '0');
            return ContentDetailScreen(contentId: id);
          },
        ),
      ],
    ),
  ],
);
