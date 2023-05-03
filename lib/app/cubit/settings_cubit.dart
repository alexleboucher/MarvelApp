import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(state.copyWith(themeMode: newThemeMode));
  }

  void changeLocale(String languageCode) {
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      themeMode:
          ThemeMode.values.firstWhere((e) => e.name == json['themeMode']),
      locale: Locale(json['locale'] as String),
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {
      'themeMode': state.themeMode.name,
      'locale': state.locale.languageCode
    };
  }
}
