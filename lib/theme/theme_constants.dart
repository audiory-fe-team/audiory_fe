import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorPaletteLight {
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

  static const Color backgroundLight = Color.fromARGB(255, 251, 248, 248);
  static const Color backgroundDark = Color(0xFF404446);
}

class ColorPaletteDark {
  static const Color primaryBase = Color(0xFF439A97);
  static const Color primaryLight = Color(0xFF69AEAC);
  static const Color primaryLighter = Color(0xFF8EC2C1);
  static const Color primaryLightest = Color(0xFF367B79);
  static const Color primaryDark = Color(0xFF367B79);
  static const Color skyBase = Color(0xFF72777A);
  static const Color skyLight = Color(0xFF6C7072);
  static const Color skyLighter = Color(0xFF404446);
  static const Color skyLightest = Color(0xFF303437);
  static const Color skyDark = Color(0xFF979C9E);
  static const Color secondaryBase = Color(0xFFDB6244);
  static const Color secondaryLight = Color(0xFFE26D69);
  static const Color secondaryLighter = Color(0xFFE9918F);
  static const Color secondaryLightest = Color(0xFFF4C8C7);
  static const Color secondaryDark = Color(0xFFAF3A36);
  static const Color inkBase = Color(0xFFF5F5F5);
  static const Color inkLight = Color(0xFFE3E5E5);
  static const Color inkLighter = Color(0xFFCDCFD0);
  static const Color inkDark = Color(0xFFE3E5E5);
  static const Color inkDarker = Color(0xFF202325);
  static const Color inkDarkest = Color(0xFF090A0A);

  static const Color backgroundLight = Color.fromARGB(255, 251, 248, 248);
  static const Color backgroundDark = Color(0xFF202325);
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
    required this.backgroundLight,
    required this.backgroundDark,
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

  final Color backgroundLight;
  final Color backgroundDark;

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
      Color? secondaryDark,
      Color? backgroundLight,
      Color? backgroundDark}) {
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
      backgroundLight: backgroundLight ?? this.backgroundLight,
      backgroundDark: backgroundDark ?? this.backgroundDark,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return const AppColors(
      primaryBase: ColorPaletteLight.primaryBase,
      primaryLight: ColorPaletteLight.primaryLight,
      primaryLighter: ColorPaletteLight.primaryLighter,
      primaryLightest: ColorPaletteLight.primaryLightest,
      primaryDark: ColorPaletteLight.primaryDark,
      skyBase: ColorPaletteLight.skyBase,
      skyLight: ColorPaletteLight.skyLight,
      skyLighter: ColorPaletteLight.skyLighter,
      skyLightest: ColorPaletteLight.skyLightest,
      skyDark: ColorPaletteLight.skyDark,
      secondaryBase: ColorPaletteLight.secondaryBase,
      secondaryLight: ColorPaletteLight.secondaryLight,
      secondaryLighter: ColorPaletteLight.secondaryLighter,
      secondaryLightest: ColorPaletteLight.secondaryLightest,
      secondaryDark: ColorPaletteLight.secondaryDark,
      inkBase: ColorPaletteLight.inkBase,
      inkLight: ColorPaletteLight.inkLight,
      inkLighter: ColorPaletteLight.inkLighter,
      inkDark: ColorPaletteLight.inkDark,
      inkDarker: ColorPaletteLight.inkDarker,
      inkDarkest: ColorPaletteLight.inkDarkest,
      backgroundLight: ColorPaletteLight.backgroundLight,
      backgroundDark: ColorPaletteLight.backgroundDark,
    );
  }
}

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: ColorPaletteLight.backgroundLight,
  iconTheme: const IconThemeData(color: ColorPaletteLight.inkBase),
  bottomAppBarTheme:
      const BottomAppBarTheme(color: ColorPaletteLight.skyLightest),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPaletteLight.backgroundLight,
    iconTheme: IconThemeData(color: ColorPaletteLight.inkBase),
  ),
  // useMaterial3: true,
  textTheme: TextTheme(
    //Heading
    headlineLarge: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.sourceSansPro(
        color: ColorPaletteLight.inkBase,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15),
    titleMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 8.0,
      fontWeight: FontWeight.w400,
    ),
    //BODY
    bodyLarge: GoogleFonts.gelasio(
      color: ColorPaletteLight.inkBase,
      fontSize: 16.0,
    ),
    bodyMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteLight.inkBase,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: ColorPaletteLight.primaryBase,
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: ColorPaletteLight.primaryBase,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
      .copyWith(background: ColorPaletteDark.primaryBase),
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      primaryBase: ColorPaletteLight.primaryBase,
      primaryLight: ColorPaletteLight.primaryLight,
      primaryLighter: ColorPaletteLight.primaryLighter,
      primaryLightest: ColorPaletteLight.primaryLightest,
      primaryDark: ColorPaletteLight.primaryDark,
      skyBase: ColorPaletteLight.skyBase,
      skyLight: ColorPaletteLight.skyLight,
      skyLighter: ColorPaletteLight.skyLighter,
      skyLightest: ColorPaletteLight.skyLightest,
      skyDark: ColorPaletteLight.skyDark,
      secondaryBase: ColorPaletteLight.secondaryBase,
      secondaryLight: ColorPaletteLight.secondaryLight,
      secondaryLighter: ColorPaletteLight.secondaryLighter,
      secondaryLightest: ColorPaletteLight.secondaryLightest,
      secondaryDark: ColorPaletteLight.secondaryDark,
      inkBase: ColorPaletteLight.inkBase,
      inkLight: ColorPaletteLight.inkLight,
      inkLighter: ColorPaletteLight.inkLighter,
      inkDark: ColorPaletteLight.inkDark,
      inkDarker: ColorPaletteLight.inkDarker,
      inkDarkest: ColorPaletteLight.inkDarkest,
      backgroundDark: ColorPaletteLight.backgroundDark,
      backgroundLight: ColorPaletteLight.backgroundLight,
    )
  ],
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorPaletteDark.backgroundDark,
  iconTheme: const IconThemeData(color: ColorPaletteDark.inkBase),
  bottomAppBarTheme:
      const BottomAppBarTheme(color: ColorPaletteDark.skyLightest),
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPaletteDark.backgroundDark,
    iconTheme: IconThemeData(color: ColorPaletteDark.inkBase),
  ),
  // useMaterial3: true,
  textTheme: TextTheme(
    //Heading
    headlineLarge: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.sourceSansPro(
        color: ColorPaletteDark.inkBase,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15),
    titleMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 8.0,
      fontWeight: FontWeight.w400,
    ),
    //BODY
    bodyLarge: GoogleFonts.gelasio(
      color: ColorPaletteDark.inkBase,
      fontSize: 16.0,
    ),
    bodyMedium: GoogleFonts.sourceSansPro(
      color: ColorPaletteDark.inkBase,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: ColorPaletteDark.primaryBase,
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: ColorPaletteDark.primaryBase,
      ),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
      .copyWith(background: ColorPaletteDark.primaryBase),
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      primaryBase: ColorPaletteDark.primaryBase,
      primaryLight: ColorPaletteDark.primaryLight,
      primaryLighter: ColorPaletteDark.primaryLighter,
      primaryLightest: ColorPaletteDark.primaryLightest,
      primaryDark: ColorPaletteDark.primaryDark,
      skyBase: ColorPaletteDark.skyBase,
      skyLight: ColorPaletteDark.skyLight,
      skyLighter: ColorPaletteDark.skyLighter,
      skyLightest: ColorPaletteDark.skyLightest,
      skyDark: ColorPaletteDark.skyDark,
      secondaryBase: ColorPaletteDark.secondaryBase,
      secondaryLight: ColorPaletteDark.secondaryLight,
      secondaryLighter: ColorPaletteDark.secondaryLighter,
      secondaryLightest: ColorPaletteDark.secondaryLightest,
      secondaryDark: ColorPaletteDark.secondaryDark,
      inkBase: ColorPaletteDark.inkBase,
      inkLight: ColorPaletteDark.inkLight,
      inkLighter: ColorPaletteDark.inkLighter,
      inkDark: ColorPaletteDark.inkDark,
      inkDarker: ColorPaletteDark.inkDarker,
      inkDarkest: ColorPaletteDark.inkDarkest,
      backgroundLight: ColorPaletteDark.backgroundLight,
      backgroundDark: ColorPaletteDark.backgroundDark,
    )
  ],
);
