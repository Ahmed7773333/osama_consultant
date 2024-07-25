import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Language', style: TextStyle(fontSize: 18)),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state is LanguageChanged ? state.language : 'en',
                  items: <String>['en', 'ar'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(SwitchLanguage(value!));
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            const Text('Notifications', style: TextStyle(fontSize: 18)),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                bool isEnabled =
                    state is NotificationToggled ? state.isEnabled : true;
                return Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(ToggleNotification(value));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
