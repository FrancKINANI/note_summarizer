import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.cardColor,
  
  // TextTheme using Google Fonts
  textTheme: TextTheme(
    displayLarge: GoogleFonts.outfit(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textLight,
    ),
    displayMedium: GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.textLight,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      color: AppColors.textLight.withValues(alpha: 0.8),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      color: AppColors.textLight.withValues(alpha: 0.7),
    ),
  ),

  // AppBar Theme
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    titleTextStyle: GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textLight,
    ),
    iconTheme: const IconThemeData(color: AppColors.textLight),
  ),

  // Card Theme
  cardTheme: CardThemeData(
    color: AppColors.cardColor,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  ),

  // Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
