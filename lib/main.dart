import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: NCDCAssignmentApp(),
    ),
  );
}

class NCDCAssignmentApp extends StatelessWidget {
  const NCDCAssignmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NCDC Assignment',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
