import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // ✅ نسخ مخصصة من الثيمات
  static final ThemeData _lightTheme = ThemeData(

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor:  Color(0xff1976D2),
    selectedItemColor: Colors.transparent

  ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.blue),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,

    ),

    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
     backgroundColor: Colors.black,
        foregroundColor: Colors.white

    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800],
        foregroundColor: Colors.white,
      ),
    ),
  );


  ThemeCubit() : super(ThemeState(_lightTheme));

  void toggleTheme(bool isDark) {
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));
    _saveTheme(isDark);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  static Future<bool> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> setInitialTheme() async {
    final isDark = await _loadTheme();
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));
  }
}
