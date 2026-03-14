import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─── Events ────────────────────────────────────────────────────────────────

abstract class ThemeEvent {}

class LoadThemeEvent extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {
  final bool isDark;
  ToggleThemeEvent(this.isDark);
}

// ─── State ─────────────────────────────────────────────────────────────────

class ThemeState {
  final ThemeMode themeMode;
  const ThemeState(this.themeMode);
}

// ─── Bloc ──────────────────────────────────────────────────────────────────

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const _key = 'dark_mode';

  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<LoadThemeEvent>(_onLoad);
    on<ToggleThemeEvent>(_onToggle);
  }

  Future<void> _onLoad(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getBool(_key);
    if (saved == null) {
      emit(const ThemeState(ThemeMode.system));
    } else {
      emit(ThemeState(saved ? ThemeMode.dark : ThemeMode.light));
    }
  }

  Future<void> _onToggle(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, event.isDark);
    emit(ThemeState(event.isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
