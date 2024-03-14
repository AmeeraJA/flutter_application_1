// ignore_for_file: unused_import

import 'package:flutter_application_1/test2/test2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodMinder',
      theme: ThemeData(
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, // Feel free to adjust the theme colors as needed
        ),
        // Use Material 3 features
        useMaterial3: true,
      ),
      home: const FoodItemPage(), // Directly set FoodItemPage as the home widget
    );
  }
}
