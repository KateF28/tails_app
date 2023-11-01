import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'locale_event.dart';

part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  LocaleBloc() : super(LocaleInitial(const Locale('uk', 'UA'))) {
    on<LocaleEvent>((event, emit) {
      on<InitLocaleEvent>(_onLocaleInit);
      on<ChangeLocaleEvent>(_onLocaleChanged);
    });
  }

  Future<void> _onLocaleChanged(
    ChangeLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    await storage.write(
        key: 'languageCode',
        value: event.locale.languageCode,
        aOptions: _getAndroidOptions());
    await storage.write(
        key: 'countryCode',
        value: event.locale.countryCode ?? '',
        aOptions: _getAndroidOptions());

    emit(LocaleUpdated(event.locale));
  }

  Future<void> _onLocaleInit(
    InitLocaleEvent event,
    Emitter<LocaleState> emit,
  ) async {
    const storage = FlutterSecureStorage();
    String languageCode = await storage.read(
            key: 'languageCode', aOptions: _getAndroidOptions()) ??
        'uk';
    String countryCode = await storage.read(
            key: 'countryCode', aOptions: _getAndroidOptions()) ??
        'UA';

    emit(LocaleUpdated(Locale(languageCode, countryCode)));
  }
}
