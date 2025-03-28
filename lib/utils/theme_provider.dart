// lib/utils/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  // Private variable with underscore prefix
  bool _isDarkMode = false;
  
  // Public getter
  bool get isDarkMode => _isDarkMode;
  
  // Constructor that initializes theme preferences
  ThemeProvider() {
    _loadThemeFromPrefs();
  }
  
  // Toggle between light and dark mode
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPrefs();
    notifyListeners();
  }
  
  // Load saved theme preference
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('is_dark_mode') ?? false;
    notifyListeners();
  }
  
  // Save theme preference
  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_dark_mode', _isDarkMode);
  }
  
  // Get current theme based on mode
  ThemeData getTheme() {
    return _isDarkMode ? _darkTheme : _lightTheme;
  }
  
  // Light theme definition
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    hintColor: Colors.lightGreen,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.green,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green[800]),
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green[700]),
      bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.black87),
      bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.black54),
    ),
    // Add smooth theme transition
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
  
  // Dark theme definition
    final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: Colors.green[700],
    hintColor: Colors.green[400],
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      color: Colors.green[700],
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green[400]),
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.green[300]),
      bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.white), // Ensure visibility in dark mode
      bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.white70), // Ensure visibility in dark mode
    ),
    // Add smooth theme transition
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}