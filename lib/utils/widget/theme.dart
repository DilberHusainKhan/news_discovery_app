// import 'dart:js';
import 'package:flutter/material.dart';
class MyTheme {
  static ThemeData get lightData => ThemeData(
        primarySwatch: Colors.deepPurple,
        // textTheme: Theme.of(context).textTheme,
      );
  static ThemeData get darkData => ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        // textTheme: Theme.of(context).textTheme,
      );
}
