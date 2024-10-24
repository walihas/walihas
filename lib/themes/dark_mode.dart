import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 57, 57, 57),
    tertiary: const Color.fromARGB(146, 58, 58, 58),
    inversePrimary: Colors.grey.shade300
  ),
  timePickerTheme: TimePickerThemeData(dayPeriodColor: Colors.grey.shade600, dialHandColor: Colors.orange.shade600, backgroundColor: Colors.grey.shade900),
  
  brightness: Brightness.dark
);