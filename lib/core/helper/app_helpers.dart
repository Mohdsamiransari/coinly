import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppHelpers {
  static String getAppVersion() {
    return '1.0.0';
  }

  static Widget buildEmptyWidget(String message) {
    return Center(
      child: Text(
        message,
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.medium,
          fontWeightVariant: FontWeightVariant.medium,
        ),
      ),
    );
  }

  static Widget buildErrorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.medium,
          fontWeightVariant: FontWeightVariant.medium,
        ),
      ),
    );
  }

  static Widget buildHeaderWidget({
    required String headingText,
    bool? isViewAll = false,
    VoidCallback? onViewAllTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headingText,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.semiBold,
          ),
        ),
        if (isViewAll == true)
          TextButton(
            onPressed: onViewAllTap,
            child: Text(
              "View All",
              style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.medium),
            ),
          ),
      ],
    );
  }
}
