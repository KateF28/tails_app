part of 'locale_bloc.dart';

@immutable
sealed class LocaleEvent {}

final class InitLocaleEvent extends LocaleEvent {}

final class ChangeLocaleEvent extends LocaleEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);
}
