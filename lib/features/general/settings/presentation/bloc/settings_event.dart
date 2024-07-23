part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SwitchLanguage extends SettingsEvent {
  final String language;

  const SwitchLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class ToggleNotification extends SettingsEvent {
  final bool isEnabled;

  const ToggleNotification(this.isEnabled);

  @override
  List<Object> get props => [isEnabled];
}
