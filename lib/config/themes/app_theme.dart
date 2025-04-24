import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getDefaultTheme() {
    return ThemeData(
      // primaryColor: Colors.redAccent,
      secondaryHeaderColor: Colors.redAccent,
      scaffoldBackgroundColor: Colors.white,
       brightness: Brightness.light,
       appBarTheme: AppBarTheme(backgroundColor: Colors.redAccent, foregroundColor:  Colors.white),
      
      colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.redAccent, onPrimary: const Color.fromARGB(255, 249, 103, 103), secondary: Colors.white, onSecondary: const Color.fromARGB(255, 243, 222, 222), error: const Color.fromARGB(255, 255, 235, 165), onError: const Color.fromARGB(255, 192, 185, 162), surface: const Color.fromARGB(60, 229, 228, 228), onSurface:  Color.fromARGB(59, 215, 215, 215)) 
    );
  }
}
