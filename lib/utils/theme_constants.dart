import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 251, 248, 248),
        iconTheme: IconThemeData(color: Colors.black),
      ),

      // primarySwatch: const MaterialColor(),
      textTheme: TextTheme(
        //HEADING
        //HEADING 1
        headlineLarge: GoogleFonts.sourceSansPro(
          color: Color.fromARGB(80, 2, 2, 2),
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
        ),
        //HEADING 2
        headlineMedium: GoogleFonts.sourceSansPro(
          color: Color.fromARGB(80, 2, 2, 2),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        //HEADING 3
        headlineSmall: GoogleFonts.sourceSansPro(
          color: Color.fromARGB(252, 2, 2, 2),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        //HEADING 4
        displayLarge: GoogleFonts.sourceSansPro(
            color: Color.fromARGB(252, 2, 2, 2),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.15),
        //SUBHEADING
        displayMedium: GoogleFonts.sourceSansPro(
          color: Color.fromARGB(252, 2, 2, 2),
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(background: const Color.fromARGB(255, 82, 184, 216)),
    );
  }
}

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    //HEADING
    //HEADING 1
    headlineLarge: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
    ),
    //HEADING 2
    headlineMedium: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    //HEADING 3
    headlineSmall: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    //HEADING 4
    displayLarge: GoogleFonts.sourceSansPro(
        color: Color.fromARGB(252, 2, 2, 2),
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.15),
    //SUBHEADING
    displayMedium: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    //BODY
    bodyLarge: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 16.0,
    ),
    //INPUT-TEXT
    bodyMedium: GoogleFonts.sourceSansPro(
        color: Color.fromARGB(252, 2, 2, 2),
        fontSize: 14.0,
        letterSpacing: 0.4),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color(0xFF439A97),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Color(0xFF439A97),
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(background: const Color.fromARGB(255, 82, 184, 216)),
);

ThemeData darkTheme = ThemeData();
