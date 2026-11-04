import 'package:flutter/material.dart';

abstract final class AppColors {
  // Colores principales de identidad.
  static const Color maritimeBlue = Color(0xFF0B3C5D);
  static const Color lagoonGreen = Color(0xFF1D7A74);
  static const Color sandOrange = Color(0xFFF2994A);
  static const Color neutralGray = Color(0xFFF4F6F8);

  // Superficies.
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE8EDF1);

  // Textos.
  static const Color primaryText = Color(0xFF162D3D);
  static const Color secondaryText = Color(0xFF60727E);
  static const Color disabledText = Color(0xFF929FA7);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // Bordes y divisores.
  static const Color border = Color(0xFFD7E0E5);
  static const Color divider = Color(0xFFE1E7EA);

  // Estados.
  static const Color success = Color(0xFF2E7D5B);
  static const Color warning = Color(0xFFE58A24);
  static const Color error = Color(0xFFBA1A1A);
  static const Color information = Color(0xFF3976A8);

  // Variantes de la paleta.
  static const Color darkMaritimeBlue = Color(0xFF072A41);
  static const Color lightMaritimeBlue = Color(0xFFD5E8F2);

  static const Color darkLagoonGreen = Color(0xFF145852);
  static const Color lightLagoonGreen = Color(0xFFD7EEEB);

  static const Color darkSandOrange = Color(0xFFBC6421);
  static const Color lightSandOrange = Color(0xFFFFE2C5);

  const AppColors._();
}