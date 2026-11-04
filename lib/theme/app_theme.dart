import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.maritimeBlue,
      brightness: Brightness.light,
      primary: AppColors.maritimeBlue,
      onPrimary: AppColors.white,
      primaryContainer: AppColors.lightMaritimeBlue,
      onPrimaryContainer: AppColors.darkMaritimeBlue,
      secondary: AppColors.lagoonGreen,
      onSecondary: AppColors.white,
      secondaryContainer: AppColors.lightLagoonGreen,
      onSecondaryContainer: AppColors.darkLagoonGreen,
      tertiary: AppColors.sandOrange,
      onTertiary: AppColors.darkMaritimeBlue,
      tertiaryContainer: AppColors.lightSandOrange,
      onTertiaryContainer: AppColors.darkSandOrange,
      error: AppColors.error,
      onError: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.primaryText,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.neutralGray,
      fontFamily: 'Roboto',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      navigationBarTheme: _navigationBarTheme,
      chipTheme: _chipTheme,
      dividerTheme: _dividerTheme,
      iconTheme: const IconThemeData(
        color: AppColors.maritimeBlue,
        size: AppDimensions.iconMedium,
      ),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    headlineLarge: AppTextStyles.headlineLarge,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: AppDimensions.appBarElevation,
    centerTitle: false,
    backgroundColor: AppColors.maritimeBlue,
    foregroundColor: AppColors.white,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
    iconTheme: IconThemeData(
      color: AppColors.white,
    ),
  );

  static const CardThemeData _cardTheme = CardThemeData(
    elevation: AppDimensions.cardElevation,
    color: AppColors.white,
    surfaceTintColor: Colors.transparent,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimensions.radiusLarge),
      ),
      side: BorderSide(
        color: AppColors.border,
        width: 0.5,
      ),
    ),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(
        double.infinity,
        AppDimensions.buttonHeight,
      ),
      backgroundColor: AppColors.maritimeBlue,
      foregroundColor: AppColors.white,
      elevation: 0,
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
      ),
    ),
  );

  static final FilledButtonThemeData _filledButtonTheme =
      FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(
        double.infinity,
        AppDimensions.buttonHeight,
      ),
      backgroundColor: AppColors.maritimeBlue,
      foregroundColor: AppColors.white,
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
      ),
    ),
  );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(
        double.infinity,
        AppDimensions.buttonHeight,
      ),
      foregroundColor: AppColors.maritimeBlue,
      side: const BorderSide(
        color: AppColors.maritimeBlue,
      ),
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusMedium,
        ),
      ),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.maritimeBlue,
      textStyle: AppTextStyles.button,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radiusSmall,
        ),
      ),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppDimensions.spacingMedium,
      vertical: AppDimensions.spacingMedium,
    ),
    hintStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.secondaryText,
    ),
    labelStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.secondaryText,
    ),
    prefixIconColor: AppColors.secondaryText,
    suffixIconColor: AppColors.secondaryText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      borderSide: const BorderSide(
        color: AppColors.border,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      borderSide: const BorderSide(
        color: AppColors.border,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      borderSide: const BorderSide(
        color: AppColors.lagoonGreen,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      borderSide: const BorderSide(
        color: AppColors.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusMedium,
      ),
      borderSide: const BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),
  );

  static const NavigationBarThemeData _navigationBarTheme =
      NavigationBarThemeData(
    height: AppDimensions.navigationBarHeight,
    backgroundColor: AppColors.white,
    indicatorColor: AppColors.lightLagoonGreen,
    elevation: 2,
    labelTextStyle: WidgetStatePropertyAll(
      AppTextStyles.labelMedium,
    ),
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        color: AppColors.maritimeBlue,
      ),
    ),
  );

  static final ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: AppColors.white,
    selectedColor: AppColors.lightLagoonGreen,
    disabledColor: AppColors.surfaceVariant,
    labelStyle: AppTextStyles.labelMedium,
    secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
      color: AppColors.darkLagoonGreen,
    ),
    side: const BorderSide(
      color: AppColors.border,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppDimensions.radiusCircular,
      ),
    ),
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: AppDimensions.spacingMedium,
  );

  const AppTheme._();
}