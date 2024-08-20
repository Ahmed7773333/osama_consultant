// ignore_for_file: must_be_immutable

part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class LanguageChanged extends SettingsState {}

class NotificationToggled extends SettingsState {}

class LanguageClicked extends SettingsState {}

class NotificationClicked extends SettingsState {}

class initSettingsState extends SettingsState {}
