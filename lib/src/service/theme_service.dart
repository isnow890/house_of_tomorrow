import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_of_tomorrow/theme/dark_theme.dart';
import 'package:house_of_tomorrow/theme/foundation/app_theme.dart';
import 'package:house_of_tomorrow/theme/light_theme.dart';

final themeServiceProvider =
    NotifierProvider<ThemeService, AppTheme>(() => ThemeService());

class ThemeService extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    // TODO: implement build
    return LightTheme();
  }

  void toggleTheme() {
    state = state.brightness == Brightness.light ? DarkTheme() : LightTheme();
  }

  /// Material ThemeData 커스텀
  ThemeData get themeData {
    print('실행됨?');
    return ThemeData(
      /// Scaffold
      scaffoldBackgroundColor: state.color.surface,

      /// AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: state.color.surface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: state.color.text,
        ),
        titleTextStyle: state.typo.headline2.copyWith(
          color: state.color.text,
        ),
      ),
    );
  }
}