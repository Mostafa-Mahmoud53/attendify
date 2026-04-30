import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const TextStyle _displayBase = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static const TextStyle _headlineBase = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static const TextStyle _titleBase = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle _bodyBase = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle _labelBase = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0.2,
  );

  static TextTheme textTheme(ColorScheme scheme) {
    final baseTheme = TextTheme(
      displayLarge: _displayBase,
      displayMedium: _displayBase,
      displaySmall: _displayBase,
      headlineLarge: _headlineBase,
      headlineMedium: _headlineBase,
      headlineSmall: _headlineBase,
      titleLarge: _titleBase,
      titleMedium: _titleBase,
      titleSmall: _titleBase,
      bodyLarge: _bodyBase,
      bodyMedium: _bodyBase,
      bodySmall: _bodyBase,
      labelLarge: _labelBase,
      labelMedium: _labelBase,
      labelSmall: _labelBase,
    );

    final interTheme = GoogleFonts.interTextTheme(baseTheme);
    return interTheme.apply(
      bodyColor: scheme.onBackground,
      displayColor: scheme.onBackground,
    );
  }

  static TextStyle display(ColorScheme scheme) =>
      GoogleFonts.inter(textStyle: _displayBase)
          .copyWith(color: scheme.onBackground);

  static TextStyle headline(ColorScheme scheme) =>
      GoogleFonts.inter(textStyle: _headlineBase)
          .copyWith(color: scheme.onBackground);

  static TextStyle title(ColorScheme scheme) =>
      GoogleFonts.inter(textStyle: _titleBase)
          .copyWith(color: scheme.onBackground);

  static TextStyle body(ColorScheme scheme) =>
      GoogleFonts.inter(textStyle: _bodyBase)
          .copyWith(color: scheme.onBackground);

  static TextStyle label(ColorScheme scheme) =>
      GoogleFonts.inter(textStyle: _labelBase)
          .copyWith(color: scheme.onBackground);
}
