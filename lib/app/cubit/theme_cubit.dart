import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggleTheme() {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeState(themeMode: newThemeMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode:
          ThemeMode.values.firstWhere((e) => e.name == json['themeMode']),
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {
      'themeMode': state.themeMode.name,
    };
  }
}
