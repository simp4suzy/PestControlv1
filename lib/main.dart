import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pest_controlv1/screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'utils/theme_provider.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Initialize ThemeProvider
      child: PestManagementApp(),
    ),
  );
}

class PestManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pestify',
          theme: themeProvider.getTheme(), // Use the theme from ThemeProvider
          home: SplashScreen(),
          routes: {
            '/home': (context) => HomeScreen(), // Changed from MainAppScreen to directly use HomeScreen
          },
        );
      },
    );
  }
}