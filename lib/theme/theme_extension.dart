import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//NOTE: Testing, not usable yet
extension CustomTextTheme on TextTheme {
  TextStyle heading1(BuildContext context) {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get heading2 {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get heading3 {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get subheading {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get num {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get body {
    return GoogleFonts.gelasio(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get inputText {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 14.0,
    );
  }

  TextStyle get caption1 {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 12.0,
    );
  }

  TextStyle get caption2 {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 10.0,
    );
  }

  TextStyle get caption3 {
    return GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 8.0,
    );
  }
}
