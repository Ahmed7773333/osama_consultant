part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SwitchLanguage extends SettingsEvent {}

class ToggleNotification extends SettingsEvent {}

class InitSettingsEvent extends SettingsEvent {}
