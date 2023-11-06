import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tails_app/main_screen.dart';
import 'package:tails_app/menu_screen.dart';
import 'package:tails_app/settings_screen.dart';
import 'package:tails_app/search_screen.dart';
import 'package:tails_app/breed_screen.dart';
import 'package:tails_app/login_screen.dart';
import 'package:tails_app/signup_screen.dart';
import 'package:tails_app/domain/feature/auth.dart';

/// The route configuration function
RouterConfig<Object> configRouter(
  bool useLightMode,
  void Function(bool useLightMode) handleBrightnessChange,
  Box box,
) {
  final loginInfo = AuthInfo();

  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, GoRouterState state) {
      final loggedIn = loginInfo.isLoggedIn;
      final String location = state.uri.toString();
      final isLoggingIn = location == '/menu/settings/login' ||
          location == '/menu/settings/signup';

      // if the user is logged in but still on the login page, send them to
      // the settings page
      if (loggedIn && isLoggingIn) return '/menu/settings';

      // no need to redirect at all
      return null;
    },
    refreshListenable: loginInfo,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: MainScreen(
              useLightMode: useLightMode,
              handleBrightnessChange: handleBrightnessChange,
              hiveBox: box,
            ),
          );
        },
      ),
      GoRoute(
        path: '/search',
        pageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SearchScreen(),
          );
        },
        routes: [
          GoRoute(
            name: 'breed',
            path: 'breeds/:breedId',
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                child: BreedScreen(breedId: state.pathParameters['breedId']!),
              );
            },
          )
        ],
      ),
      GoRoute(
          path: '/menu',
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: const MenuScreen(),
            );
          },
          routes: [
            GoRoute(
                path: 'settings',
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: SettingsScreen(hiveBox: box),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'login',
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        key: state.pageKey,
                        child: const LoginScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'signup',
                    pageBuilder: (context, state) {
                      return MaterialPage(
                        key: state.pageKey,
                        child: const SignupScreen(),
                      );
                    },
                  ),
                ]),
          ]),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(state.error.toString()),
          ),
        ),
      );
    },
  );
}
