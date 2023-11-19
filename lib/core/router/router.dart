import 'package:ccp_clean_architecture/src/splashscreen/presentation/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _parentKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

class Routes {
  // Initial Routes
  static const String splash = '/';

  // Bottom Navigation Routes / Main Menu
  static const String home = '/home';
  static const String search = '/search';
  static const String favorite = '/favorite';
  static const String profile = '/profile';

  // App Routes
  static const String settings = '/settings';
  static const String detail = '/detail';
}

final GoRouter _router = GoRouter(
  initialLocation: Routes.splash,
  navigatorKey: _parentKey,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    // Bottom Navigation Route / Main Menu
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => const Placeholder(),
      routes: [
        // Home
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: Routes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Placeholder(),
          ),
        ),
        // Search
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: Routes.search,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Placeholder(),
          ),
        ),

        // Favorite
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: Routes.favorite,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Placeholder(),
          ),
        ),

        // Profile
        GoRoute(
          parentNavigatorKey: _shellKey,
          path: Routes.profile,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Placeholder(),
          ),
        ),
      ],
    ),

    // Initial Routes Splashscreen
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

    // Detail
    GoRoute(
        parentNavigatorKey: _parentKey,
        path: "${Routes.detail}/:detailId",
        builder: (context, state) {
          String detailId = state.pathParameters['detailId']!;

          return const Placeholder();
        }),

    // Settings
    GoRoute(
        parentNavigatorKey: _parentKey,
        path: Routes.settings,
        builder: (context, state) {
          Map<String, dynamic> extra = {};
          Object? obj;

          if (state.extra != null) {
            extra = state.extra as Map<String, dynamic>;
            obj = extra["obj"];
          }

          return const Placeholder();
        }),
  ],
);

GoRouter get router => _router;
