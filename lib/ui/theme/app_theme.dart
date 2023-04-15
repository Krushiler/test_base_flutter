import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_base_flutter/ui/theme/app_colors.dart';
import 'package:test_base_flutter/ui/theme/app_text_theme.dart';
import 'package:test_base_flutter/ui/dimens.dart';

final appTheme = ThemeData(
  fontFamily: 'Archivo',
  textTheme: appTextTheme,
  colorScheme: const ColorScheme.light(
    primary: AppColors.brandPrimary,
    secondary: AppColors.brandPrimary,
    background: AppColors.defaultBackground,
    primaryContainer: AppColors.brandPrimaryContainer,
  ),
  appBarTheme: AppBarTheme(
      toolbarHeight: Dimens.xxl,
      color: AppColors.defaultBackground,
      elevation: 0,
      titleSpacing: 0,
      titleTextStyle: appTextTheme.h3,
      centerTitle: true,
      toolbarTextStyle: appTextTheme.buttonMedium?.copyWith(
          color: AppColors.brandPrimary,
          leadingDistribution: TextLeadingDistribution.even),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.defaultBackground,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      )),
  tabBarTheme: const TabBarTheme(
    overlayColor: MaterialStatePropertyAll<Color>(AppColors.brandPrimary),
  ),
  scaffoldBackgroundColor: AppColors.defaultBackground,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.brandPrimary,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      padding: const MaterialStatePropertyAll(
        EdgeInsets.all(Dimens.md + Dimens.xs),
      ),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.sm),
        ),
      ),
      textStyle: MaterialStatePropertyAll(appTextTheme.buttonLarge),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(AppColors.gray.shade100),
      foregroundColor:
          const MaterialStatePropertyAll(AppColors.defaultForeground),
      padding:
          const MaterialStatePropertyAll(EdgeInsets.all(Dimens.md + Dimens.xs)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.sm)),
      ),
      side: const MaterialStatePropertyAll(
        BorderSide(width: 0, color: Colors.transparent),
      ),
      textStyle: MaterialStatePropertyAll(
        appTextTheme.buttonLarge,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: const MaterialStatePropertyAll(0),
      textStyle: MaterialStatePropertyAll(appTextTheme.buttonLarge),
    ),
  ),
);
