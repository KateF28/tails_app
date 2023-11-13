import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:provider/provider.dart';

import 'package:tails_app/presentation/widgets/tails_material_app.dart';
import 'package:tails_app/domain/feature/breeds_list/bloc/breeds_list_bloc.dart';
import 'package:tails_app/data/datasources/remote/repository.dart';
import 'package:tails_app/data/datasources/remote/dogs_api.dart';
import 'package:tails_app/domain/feature/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Remove the # prefix from the web URL
  usePathUrlStrategy();

  Bloc.observer = _MyStoreAppBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(LocaleAdapter());
  await Hive.openBox('settings');

  runApp(const MyApp());
}

/// This is main App widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => Repository(DogsApi()),
      child: BlocProvider(
        create: (BuildContext context) => BreedsListBloc(
          RepositoryProvider.of<Repository>(context),
        )..add(RequestBreedsListEvent()),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => AuthInfo(),
          child: const TailsMaterialApp(),
        ),
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

/// Hive adapter for Locale
class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final typeId = 0;

  @override
  Locale read(BinaryReader reader) {
    return Locale(reader.read());
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.write(obj.languageCode);
    writer.write(obj.countryCode);
  }
}
