import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.blue;
  static const Color secudary = Colors.grey;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
      primaryColor: primary,
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: secudary,
        focusColor: primary,
        hoverColor: primary,
        prefixIconColor: Color.fromARGB(192, 129, 127, 127),
        floatingLabelStyle: TextStyle(color: secudary),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secudary),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        errorStyle: TextStyle(color: Colors.red),
      ));
}
