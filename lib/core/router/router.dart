import 'package:ccp_clean_architecture/src/auth/views/sign_in_screen.dart';
import 'package:ccp_clean_architecture/src/auth/views/sign_up_screen.dart';
import 'package:ccp_clean_architecture/src/explore/views/explore_screen.dart';
import 'package:ccp_clean_architecture/src/favorites/views/favorites_screen.dart';
import 'package:ccp_clean_architecture/src/home/views/home_screen.dart';
import 'package:ccp_clean_architecture/src/main_menu/views/main_menu_screen.dart';
import 'package:ccp_clean_architecture/src/on_boarding/views/on_boarding_screen.dart';
import 'package:ccp_clean_architecture/src/profile/views/profile_screen.dart';
import 'package:ccp_clean_architecture/src/splashscreen/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter get router => _router;

final _parentKey = GlobalKey<NavigatorState>();

final _shellKey = GlobalKey<NavigatorState>();

const _initial = '/';

final GoRouter _router = GoRouter(
  initialLocation: _initial,
  navigatorKey: _parentKey,
  errorBuilder: (context, state) => const Placeholder(),
  routes: [
    // Initial Routes Splashscreen
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: _initial,
      builder: (context, state) => const SplashScreen(),
    ),

    // on first launch app will show on boarding screen
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: OnBoardingScreen.route,
      builder: (context, state) => const OnBoardingScreen(),
    ),

    // Auth sign in / sign up
    ..._routeAuth,

    // Bottom Navigation Route / Main Menu
    ..._routeMainMenu,

    // Detail
    GoRoute(
        parentNavigatorKey: _parentKey,
        path: "/detail/:detailId",
        builder: (context, state) {
          String detailId = state.pathParameters['detailId']!;

          return const Placeholder();
        }),

    // Settings
    GoRoute(
      parentNavigatorKey: _parentKey,
      path: '/settings',
      builder: (context, state) {
        Map<String, dynamic> extra = {};
        Object? obj;

        if (state.extra != null) {
          extra = state.extra as Map<String, dynamic>;
          obj = extra["obj"];
        }

        return const Placeholder();
      },
    ),
  ],
);

final _routeMainMenu = [
  // Bottom Navigation Route / Main Menu
  ShellRoute(
    navigatorKey: _shellKey,
    builder: (context, state, child) =>
        MainMenuScreen(location: state.fullPath!, child: child),
    routes: [
      // Home
      GoRoute(
        parentNavigatorKey: _shellKey,
        path: HomeScreen.route,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomeScreen(),
        ),
      ),

      // Explore
      GoRoute(
        parentNavigatorKey: _shellKey,
        path: ExploreScreen.route,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ExploreScreen(),
        ),
      ),

      // Favorites
      GoRoute(
        parentNavigatorKey: _shellKey,
        path: FavoritesScreen.route,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: FavoritesScreen(),
        ),
      ),

      // Profile
      GoRoute(
        parentNavigatorKey: _shellKey,
        path: ProfileScreen.route,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: ProfileScreen(),
        ),
      ),
    ],
  ),
];

final _routeAuth = [
  GoRoute(
    parentNavigatorKey: _parentKey,
    path: SignInScreen.route,
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    parentNavigatorKey: _parentKey,
    path: SignUpScreen.route,
    builder: (context, state) => const SignUpScreen(),
  ),
];
