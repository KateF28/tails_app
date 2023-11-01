part of 'locale_bloc.dart';

@immutable
abstract class LocaleState {}

class LocaleInitial extends LocaleState {
  final Locale locale;

  LocaleInitial(this.locale);
}

class LocaleUpdated extends LocaleState {
  final Locale locale;

  LocaleUpdated(this.locale);
}
