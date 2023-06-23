import 'package:flutter/material.dart';
import 'package:lucio/data/const.dart';

ThemeData light(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
      useMaterial3: true,
      textTheme: Theme.of(context).textTheme.copyWith().apply(
            fontSizeFactor: 1.2,
            fontSizeDelta: 0.3,
            fontFamily: "DIN",
            bodyColor: Colors.black,
            displayColor: Colors.black,
            decorationColor: Colors.black,
          ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(kDefaultRefNumber * 1.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultRefNumber/2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultRefNumber/2),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultRefNumber/2),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.grey.shade50,
        filled: true,
        hintStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        labelStyle: const TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
      ),
    );
