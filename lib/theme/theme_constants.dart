import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorPalette {
  static const Color primaryBase = Color(0xFF439A97);
  static const Color primaryLight = Color(0xFF69AEAC);
  static const Color primaryLighter = Color(0xFF8EC2C1);
  static const Color primaryLightest = Color(0xFFD9EBEA);
  static const Color primaryDark = Color(0xFF367B79);
  static const Color skyBase = Color(0xFFCDCFD0);
  static const Color skyLight = Color(0xFFE3E5E5);
  static const Color skyLighter = Color(0xFFE3E5E5);
  static const Color skyLightest = Color(0xFFF5F5F5);
  static const Color skyDark = Color(0xFF979C9E);
  static const Color secondaryBase = Color(0xFFDB6244);
  static const Color secondaryLight = Color(0xFFE26D69);
  static const Color secondaryLighter = Color(0xFFE9918F);
  static const Color secondaryLightest = Color(0xFFF4C8C7);
  static const Color secondaryDark = Color(0xFFAF3A36);
  static const Color inkBase = Color(0xFF404446);
  static const Color inkLight = Color(0xFF6C7072);
  static const Color inkLighter = Color(0xFF72777A);
  static const Color inkDark = Color(0xFF303437);
  static const Color inkDarker = Color(0xFF202325);
  static const Color inkDarkest = Color(0xFF090A0A);
}

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
    required this.inkDark,
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
  final Color inkDark;
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
      Color? inkDark,
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
      inkDark: inkDark ?? this.inkDark,
      inkDarker: inkDarker ?? this.inkDarker,
      inkDarkest: inkDarkest ?? this.inkDarkest,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return const AppColors(
      primaryBase: ColorPalette.primaryBase,
      primaryLight: ColorPalette.primaryLight,
      primaryLighter: ColorPalette.primaryLighter,
      primaryLightest: ColorPalette.primaryLightest,
      primaryDark: ColorPalette.primaryDark,
      skyBase: ColorPalette.skyBase,
      skyLight: ColorPalette.skyLight,
      skyLighter: ColorPalette.skyLighter,
      skyLightest: ColorPalette.skyLightest,
      skyDark: ColorPalette.skyDark,
      secondaryBase: ColorPalette.secondaryBase,
      secondaryLight: ColorPalette.secondaryLight,
      secondaryLighter: ColorPalette.secondaryLighter,
      secondaryLightest: ColorPalette.secondaryLightest,
      secondaryDark: ColorPalette.secondaryDark,
      inkBase: ColorPalette.inkBase,
      inkLight: ColorPalette.inkLight,
      inkLighter: ColorPalette.inkLighter,
      inkDark: ColorPalette.inkDark,
      inkDarker: ColorPalette.inkDarker,
      inkDarkest: ColorPalette.inkDarkest,
    );
  }
}

ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  // useMaterial3: true,
  textTheme: TextTheme(
    //Heading
    headlineLarge: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.sourceSansPro(
        color: ColorPalette.inkBase,
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15),
    titleMedium: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 8.0,
      fontWeight: FontWeight.w400,
    ),
    //BODY
    bodyLarge: GoogleFonts.gelasio(
      color: ColorPalette.inkBase,
      fontSize: 16.0,
    ),
    bodyMedium: GoogleFonts.sourceSansPro(
      color: ColorPalette.inkBase,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: ColorPalette.primaryBase,
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: ColorPalette.primaryBase,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
      .copyWith(background: const Color.fromARGB(255, 82, 184, 216)),
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      primaryBase: ColorPalette.primaryBase,
      primaryLight: ColorPalette.primaryLight,
      primaryLighter: ColorPalette.primaryLighter,
      primaryLightest: ColorPalette.primaryLightest,
      primaryDark: ColorPalette.primaryDark,
      skyBase: ColorPalette.skyBase,
      skyLight: ColorPalette.skyLight,
      skyLighter: ColorPalette.skyLighter,
      skyLightest: ColorPalette.skyLightest,
      skyDark: ColorPalette.skyDark,
      secondaryBase: ColorPalette.secondaryBase,
      secondaryLight: ColorPalette.secondaryLight,
      secondaryLighter: ColorPalette.secondaryLighter,
      secondaryLightest: ColorPalette.secondaryLightest,
      secondaryDark: ColorPalette.secondaryDark,
      inkBase: ColorPalette.inkBase,
      inkLight: ColorPalette.inkLight,
      inkLighter: ColorPalette.inkLighter,
      inkDark: ColorPalette.inkDark,
      inkDarker: ColorPalette.inkDarker,
      inkDarkest: ColorPalette.inkDarkest,
    )
  ],
);

ThemeData darkTheme = ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
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
      inkDark: Color(0xFFD9EBEA),
      inkDarker: Color(0xFF367B79),
      inkDarkest: Color(0xFF367B79),
    )
  ],
);
