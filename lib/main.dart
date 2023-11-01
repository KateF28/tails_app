import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tails_app/tails_material_app.dart';
import 'package:tails_app/domain/feature/locale/bloc/locale_bloc.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/data/repository.dart';
import 'package:tails_app/data/api/mock_api.dart';

void main() {
  Bloc.observer = _MyStoreAppBlocObserver();
  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => MockRepository(MockAPI()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LocaleBloc>(
            create: (BuildContext context) => LocaleBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => BreedsListBloc(
              RepositoryProvider.of<MockRepository>(context),
            ),
          ),
        ],
        child: const TailsMaterialApp(),
      ),
    );
  }
}

/// Bloc observer for logging purposes
class _MyStoreAppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint(event?.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint(
        '$bloc changed from ${change.currentState} to ${change.nextState}');
    super.onChange(bloc, change);
  }
}
