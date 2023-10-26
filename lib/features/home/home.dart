import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jwell_store/features/cats/presentation/screens/task_screen.dart';
import 'package:jwell_store/features/item_screen.dart';

import '../../widgets/app_scaffold.dart';
import '../auth/auth.dart';
import '../settings/presentation/screens/settings_screen.dart';
import 'presentation/screens/home_screen.dart';

class HomeFeature extends Feature {
  @override
  List<RouteBase> get routes => [
        ShellRoute(
          builder: (context, state, child) {
            return AppScaffold(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: HomeScreen.routePath,
              builder: (context, state) => const HomeScreen(),
              redirect: (context, state) {
                final ref = ProviderScope.containerOf(context);
                final authState = ref.read(authStateProvider);
                if (authState is! Authenticated) {
                  return LoginScreen.routePath;
                }
                return null;
              },
            ),
            GoRoute(
              path: CatScreen.routePath,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsScreen();
              },
            ),
            GoRoute(
              path: '/cat/:categoryId',
              builder: (context, state) {
                final categoryId = state.params['categoryId']!;
                return ItemScreen(categoryId: categoryId);
              },
            ),
            GoRoute(
              path: HomeScreen.routePath,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              path: SettingsScreen.routePath,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsScreen();
              },
            ),
          ],
        ),
      ];
}
