import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SwitchLanguage>(_onSwitchLanguage);
    on<ToggleNotification>(_onToggleNotification);
  }

  void _onSwitchLanguage(SwitchLanguage event, Emitter<SettingsState> emit) {
    emit(LanguageChanged(event.language));
  }

  void _onToggleNotification(
      ToggleNotification event, Emitter<SettingsState> emit) {
    emit(NotificationToggled(event.isEnabled));
  }
}
