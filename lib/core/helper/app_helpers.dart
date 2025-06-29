import 'package:coinly/core/common/model/date_time_model.dart';
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

  static DateTimeModel dateTimeFunction(String input) {
    final dateTime = DateTime.parse(input);
    // Format date as YYYY-MM-DD
    final date = "${dateTime.year.toString().padLeft(4, '0')}-"
        "${dateTime.month.toString().padLeft(2, '0')}-"
        "${dateTime.day.toString().padLeft(2, '0')}";

    // Format time as HH:MM:SS
    final time = "${dateTime.hour.toString().padLeft(2, '0')}:"
        "${dateTime.minute.toString().padLeft(2, '0')}:"
        "${dateTime.second.toString().padLeft(2, '0')}";

    return DateTimeModel(date: date,time: time);
  }
}
