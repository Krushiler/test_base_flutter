import 'package:flutter/material.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';

final appTextTheme = const TextTheme(
  // Headline
  displayLarge:
      TextStyle(fontSize: 32, height: 1.25, fontWeight: FontWeight.w700),
  displayMedium:
      TextStyle(fontSize: 24, height: 1.33, fontWeight: FontWeight.w700),
  displaySmall:
      TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w700),
  headlineLarge:
      TextStyle(fontSize: 14, height: 1.43, fontWeight: FontWeight.w700),

  // Body
  bodyLarge: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(fontSize: 14, height: 1.43, fontWeight: FontWeight.w400),
  bodySmall: TextStyle(fontSize: 12, height: 1.33, fontWeight: FontWeight.w400),

  // Button
  labelLarge: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(fontSize: 14, height: 1.43, fontWeight: FontWeight.w500),
  labelSmall: TextStyle(fontSize: 12, height: 1.33, fontWeight: FontWeight.w500),
).apply(
    bodyColor: AppColors.defaultForeground,
    displayColor: AppColors.defaultForeground);

extension AppTextTheme on TextTheme {
  // Headline
  TextStyle? get h1 => displayLarge;

  TextStyle? get h2 => displayMedium;

  TextStyle? get h3 => displaySmall;

  TextStyle? get h4 => headlineLarge;

  // Body
  TextStyle? get p1 => bodyLarge;

  TextStyle? get p2 => bodyMedium;

  TextStyle? get p3 => bodySmall;

  // Button
  TextStyle? get buttonLarge => labelLarge;

  TextStyle? get buttonMedium => labelMedium;

  TextStyle? get buttonSmall => labelSmall;

  // Input
  TextStyle? get inputLabel => bodySmall;

  TextStyle? get inputText => bodyLarge;

  TextStyle? get inputSubLabel => bodySmall;

  TextStyle? get inputAction => bodySmall?.copyWith(fontWeight: FontWeight.w700);
}

extension AppTextStyle on TextStyle {
  TextStyle? get doubleHeight => copyWith(height: 2);

  TextStyle? get bold => copyWith(fontWeight: FontWeight.w700);
}