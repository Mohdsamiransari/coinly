import 'package:coinly/utils/app_colors.dart';
import 'package:flutter/material.dart';

// Enums for font weights, colors, and sizes
enum FontWeightVariant { bold, semiBold, medium, regular }

enum ColorVariant { white, black, primary, secondary, primaryWhite }

enum SizeVariant {
  small,
  medium,
  mediumLarge,
  large,
  extraLarge,
  extraExtraLarge
}

class AppTextStyles {
  // Mapping enums to actual values
  static const Map<FontWeightVariant, FontWeight> fontWeights = {
    FontWeightVariant.bold: FontWeight.w700,
    FontWeightVariant.semiBold: FontWeight.w600,
    FontWeightVariant.medium: FontWeight.w500,
    FontWeightVariant.regular: FontWeight.w400,
  };

  static const Map<ColorVariant, Color> colorVariants = {
    ColorVariant.white: AppColors.white,
    ColorVariant.black: AppColors.black,
    ColorVariant.primary: AppColors.primaryBlue,
    ColorVariant.secondary: AppColors.secondaryBlue,
    ColorVariant.primaryWhite: AppColors.primaryWhite,
  };

  static const Map<SizeVariant, double> sizeVariants = {
    SizeVariant.small: 12.0,
    SizeVariant.medium: 16.0,
    SizeVariant.mediumLarge: 20.0,
    SizeVariant.large: 24.0,
    SizeVariant.extraLarge: 32.0,
    SizeVariant.extraExtraLarge: 42.0
  };

  // Method to generate text style based on enums
  static TextStyle getStyle({
    required ColorVariant colorVariant,
    required SizeVariant sizeVariant,
    FontWeightVariant fontWeightVariant = FontWeightVariant.regular,
    double letterSpacing = 0,
  }) {
    return TextStyle(
      color: colorVariants[colorVariant],
      fontSize: sizeVariants[sizeVariant],
      fontWeight: fontWeights[fontWeightVariant],
      letterSpacing: letterSpacing,
    );
  }
}
