import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primaryBase,
    required this.primaryLight,
    required this.primaryLighter,
    required this.primaryLightest,
    required this.primaryDark,
    required this.skyBase,
    required this.skyLight,
    required this.skyLighter,
    required this.skyLightest,
    required this.skyDark,
    required this.inkBase,
    required this.inkLight,
    required this.inkLighter,
    required this.inkLightest,
    required this.inkDarker,
    required this.inkDarkest,
    required this.secondaryBase,
    required this.secondaryLight,
    required this.secondaryLighter,
    required this.secondaryLightest,
    required this.secondaryDark,
  });

  final Color primaryBase;
  final Color primaryLight;
  final Color primaryLighter;
  final Color primaryLightest;
  final Color primaryDark;

  final Color skyBase;
  final Color skyLight;
  final Color skyLighter;
  final Color skyLightest;
  final Color skyDark;

  final Color inkBase;
  final Color inkLight;
  final Color inkLighter;
  final Color inkLightest;
  final Color inkDarker;
  final Color inkDarkest;

  final Color secondaryBase;
  final Color secondaryLight;
  final Color secondaryLighter;
  final Color secondaryLightest;
  final Color secondaryDark;

  @override
  AppColors copyWith(
      {Color? primaryBase,
      Color? primaryLight,
      Color? primaryLighter,
      Color? primaryLightest,
      Color? primaryDark,
      Color? inkBase,
      Color? inkLight,
      Color? inkLighter,
      Color? inkLightest,
      Color? inkDarker,
      Color? inkDarkest,
      Color? skyBase,
      Color? skyLight,
      Color? skyLighter,
      Color? skyLightest,
      Color? skyDark,
      Color? secondaryBase,
      Color? secondaryLight,
      Color? secondaryLighter,
      Color? secondaryLightest,
      Color? secondaryDark}) {
    return AppColors(
      primaryBase: primaryBase ?? this.primaryBase,
      primaryLight: primaryLight ?? this.primaryLight,
      primaryLighter: primaryLighter ?? this.primaryLighter,
      primaryLightest: primaryLightest ?? this.primaryLightest,
      primaryDark: primaryDark ?? this.primaryDark,
      skyBase: skyBase ?? this.skyBase,
      skyLight: skyLight ?? this.skyLight,
      skyLighter: skyLighter ?? this.skyLighter,
      skyLightest: skyLightest ?? this.skyLightest,
      skyDark: skyDark ?? this.skyDark,
      secondaryBase: secondaryBase ?? this.secondaryBase,
      secondaryLight: secondaryLight ?? this.secondaryLight,
      secondaryLighter: secondaryLighter ?? this.secondaryLighter,
      secondaryLightest: secondaryLightest ?? this.secondaryLightest,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      inkBase: inkBase ?? this.inkBase,
      inkLight: inkLight ?? this.inkLight,
      inkLighter: inkLighter ?? this.inkLighter,
      inkLightest: inkLightest ?? this.inkLightest,
      inkDarker: inkDarker ?? this.inkDarker,
      inkDarkest: inkDarkest ?? this.inkDarkest,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryBase: Color(0xFF439A97),
      primaryLight: Color(0xFF69AEAC),
      primaryLighter: Color(0xFF8EC2C1),
      primaryLightest: Color(0xFFD9EBEA),
      primaryDark: Color(0xFF367B79),
      skyBase: Color(0xFF439A97),
      skyLight: Color(0xFF69AEAC),
      skyLighter: Color(0xFF8EC2C1),
      skyLightest: Color(0xFFD9EBEA),
      skyDark: Color(0xFF367B79),
      secondaryBase: Color(0xFF439A97),
      secondaryLight: Color(0xFF69AEAC),
      secondaryLighter: Color(0xFF8EC2C1),
      secondaryLightest: Color(0xFFD9EBEA),
      secondaryDark: Color(0xFF367B79),
      inkBase: Color(0xFF439A97),
      inkLight: Color(0xFF69AEAC),
      inkLighter: Color(0xFF8EC2C1),
      inkLightest: Color(0xFFD9EBEA),
      inkDarker: Color(0xFF367B79),
      inkDarkest: Color(0xFF367B79),
    );
  }
}

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: TextTheme(
    //Heading
    headlineLarge: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(80, 2, 2, 2),
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.sourceSansPro(
        color: Color.fromARGB(252, 2, 2, 2),
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15),
    titleMedium: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: GoogleFonts.sourceSansPro(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 8.0,
      fontWeight: FontWeight.w400,
    ),
    //BODY
    bodyLarge: GoogleFonts.gelasio(
      color: Color.fromARGB(252, 2, 2, 2),
      fontSize: 16.0,
    ),
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
  extensions: <ThemeExtension<dynamic>>[
    const AppColors(
      primaryBase: Color(0xFF439A97),
      primaryLight: Color(0xFF69AEAC),
      primaryLighter: Color(0xFF8EC2C1),
      primaryLightest: Color(0xFFD9EBEA),
      primaryDark: Color(0xFF367B79),
      skyBase: Color(0xFF439A97),
      skyLight: Color(0xFF69AEAC),
      skyLighter: Color(0xFF8EC2C1),
      skyLightest: Color(0xFFD9EBEA),
      skyDark: Color(0xFF367B79),
      secondaryBase: Color(0xFF439A97),
      secondaryLight: Color(0xFF69AEAC),
      secondaryLighter: Color(0xFF8EC2C1),
      secondaryLightest: Color(0xFFD9EBEA),
      secondaryDark: Color(0xFF367B79),
      inkBase: Color(0xFF439A97),
      inkLight: Color(0xFF69AEAC),
      inkLighter: Color(0xFF8EC2C1),
      inkLightest: Color(0xFFD9EBEA),
      inkDarker: Color(0xFF367B79),
      inkDarkest: Color(0xFF367B79),
    )
  ],
);

ThemeData darkTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    const AppColors(
      primaryBase: Color(0xFF439A97),
      primaryLight: Color(0xFF69AEAC),
      primaryLighter: Color(0xFF8EC2C1),
      primaryLightest: Color(0xFFD9EBEA),
      primaryDark: Color(0xFF367B79),
      skyBase: Color(0xFF439A97),
      skyLight: Color(0xFF69AEAC),
      skyLighter: Color(0xFF8EC2C1),
      skyLightest: Color(0xFFD9EBEA),
      skyDark: Color(0xFF367B79),
      secondaryBase: Color(0xFF439A97),
      secondaryLight: Color(0xFF69AEAC),
      secondaryLighter: Color(0xFF8EC2C1),
      secondaryLightest: Color(0xFFD9EBEA),
      secondaryDark: Color(0xFF367B79),
      inkBase: Color(0xFF439A97),
      inkLight: Color(0xFF69AEAC),
      inkLighter: Color(0xFF8EC2C1),
      inkLightest: Color(0xFFD9EBEA),
      inkDarker: Color(0xFF367B79),
      inkDarkest: Color(0xFF367B79),
    )
  ],
);
