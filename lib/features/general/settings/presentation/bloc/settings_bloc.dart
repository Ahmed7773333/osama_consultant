import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osama_consul/core/cache/shared_prefrence.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  static SettingsBloc get(context) => BlocProvider.of(context);
  bool isNotificationsEnabled = true;
  bool isEnglish = true;
  SettingsBloc() : super(SettingsInitial()) {
    on<InitSettingsEvent>(_initalSettingsEvent);
    on<SwitchLanguage>(_onSwitchLanguage);
    on<ToggleNotification>(_onToggleNotification);
  }

  void _onSwitchLanguage(
      SwitchLanguage event, Emitter<SettingsState> emit) async {
    emit(LanguageClicked());
    isEnglish = !isEnglish;
    await UserPreferences.setIsEnglish(isEnglish);
    emit(LanguageChanged());
  }

  void _onToggleNotification(
      ToggleNotification event, Emitter<SettingsState> emit) async {
    emit(NotificationClicked());

    isNotificationsEnabled = !isNotificationsEnabled;
    await UserPreferences.setIsNotificationEnabled(isNotificationsEnabled);

    emit(NotificationToggled());
  }

  void _initalSettingsEvent(
      InitSettingsEvent event, Emitter<SettingsState> emit) async {
    isEnglish = (await UserPreferences.getIsEnglish()) ?? true;
    isNotificationsEnabled =
        (await UserPreferences.getIsNotificationEnabled()) ?? true;
    emit(initSettingsState());
  }
}
