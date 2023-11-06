import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tails_app/main_screen.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/domain/models/breed.dart';
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
  final authInfo = AuthInfo();

  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final loggedIn = authInfo.isLoggedIn;
      final isLoggingIn = state.uri.toString() == '/menu/settings/login';
      final isSigningUp = state.uri.toString() == '/menu/settings/signup';

      if (loggedIn && isLoggingIn) return '/menu/settings';
      if (loggedIn && isSigningUp) return '/menu/settings';

      return null;
    },
    refreshListenable: authInfo,
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
              final breedsListState =
                  context.read<BreedsListBloc>().state as BreedsListLoaded;
              final Breed breed;
              breed = breedsListState.breeds.firstWhere(
                (element) => element.id == state.pathParameters['breedId'],
              );

              return MaterialPage(
                key: state.pageKey,
                child: BreedScreen(breed: breed),
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
