import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
      surface: const Color.fromARGB(255, 245, 245, 245),
      primary: Colors.grey.shade600,
      secondary: Colors.grey.shade200,
      tertiary: Colors.white,
      inversePrimary: Colors.grey.shade900),
  timePickerTheme: TimePickerThemeData(dayPeriodColor: Colors.grey.shade500, dialHandColor: Colors.orange.shade600, backgroundColor: const Color.fromARGB(255, 245, 245, 245)),
  brightness: Brightness.light,
);
