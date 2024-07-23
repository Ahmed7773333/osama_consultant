part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class LanguageChanged extends SettingsState {
  final String language;

  const LanguageChanged(this.language);

  @override
  List<Object> get props => [language];
}

class NotificationToggled extends SettingsState {
  final bool isEnabled;

  const NotificationToggled(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}
