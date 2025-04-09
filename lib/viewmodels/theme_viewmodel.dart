import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;

  static final _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFC1CC),
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 10,
      sizeConstraints: BoxConstraints.tightFor(
        width: 60,
        height: 60,
      ),
      shape: CircleBorder(),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[400],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(color: Colors.black),
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.black), // Màu chữ cho Light Mode
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white), // Màu nền menu thả xuống
      ),
    ),
  );

  static final _darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 10,
      sizeConstraints: BoxConstraints.tightFor(
        width: 60,
        height: 60,
      ),
      shape: CircleBorder(),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(color: Colors.white),
    ),
    cardTheme: const CardTheme(
      color: Colors.grey,
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.white), // Màu chữ cho Dark Mode
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.grey), // Màu nền menu thả xuống
      ),
    ),
  );

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}