part of 'splash_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object> get props => [];
}

class ChangeLocaleState extends LocaleState {
  final Locale selectedLocale;
  const ChangeLocaleState(this.selectedLocale) : super(selectedLocale);
}
