import 'package:flutter_application_1/models/food_category.dart';
import 'package:flutter_application_1/test2/test2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodMinder',
      theme: ThemeData(
        // Define the default brightness and colors.
        textTheme: GoogleFonts.sourceCodeProTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors
              .deepPurple, // Feel free to adjust the theme colors as needed
        ),
        // Use Material 3 features
        useMaterial3: true,
      ),
      home: FoodItemPage(
        foodCat: foodCategories[0], //Note: The range is 0-6
      ), // Directly set FoodItemPage as the home widget
    );
  }
}
