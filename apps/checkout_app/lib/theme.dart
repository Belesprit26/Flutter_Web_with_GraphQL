import 'package:flutter/material.dart';

/// The fictional marketplace's name. Invented; it doesn't imitate any real
/// company.
const String brandName = 'Brightnook';

/// "Checkout · Brightnook" - the browser tab title for a page.
String pageTitle(String page) => '$page · $brandName';

/// Brightnook's colours. Light only.
abstract final class AppColors {
  static const Color primary = Color(0xFF2F6F5E);
  static const Color background = Color(0xFFF6F7F4);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF1C2421);
  static const Color mutedText = Color(0xFF5C6662);
  static const Color outline = Color(0xFFDDE2DE);
  static const Color danger = Color(0xFFB3261E);
}

abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
}

/// Content stops growing past this width and sits centred on wide screens.
const double maxContentWidth = 960;

abstract final class AppTheme {
  static ThemeData light() {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      outline: AppColors.outline,
      error: AppColors.danger,
    );
    final RoundedRectangleBorder rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadii.md),
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
      dividerTheme: const DividerThemeData(color: AppColors.outline),
      listTileTheme: const ListTileThemeData(
        subtitleTextStyle: TextStyle(color: AppColors.mutedText),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        side: const BorderSide(color: AppColors.outline),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: rounded,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: rounded,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
    );
  }
}
