import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);
  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark();

  toggleTheme() {
    emit(state == lightTheme ? darkTheme : lightTheme);
  }
}
