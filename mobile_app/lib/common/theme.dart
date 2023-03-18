import 'package:flutter/material.dart';

ThemeData customDarkTheme() {
  const Color primaryColor = Colors.white;
  const Color accentColor = Colors.white;
  const colorInputField = Color.fromARGB(132, 206, 205, 205);
  final borderRadius = BorderRadius.circular(10);

  return ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorInputField,
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorInputField),
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorInputField),
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorInputField),
          borderRadius: borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorInputField),
          borderRadius: borderRadius,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: colorInputField),
          borderRadius: borderRadius,
        ),
        contentPadding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        border: InputBorder.none,
        errorStyle: TextStyle(
          color: Colors.red[400],
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
        labelStyle: const TextStyle(color: Color.fromARGB(255, 110, 110, 110))),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
        .copyWith(secondary: accentColor),
  );
}
