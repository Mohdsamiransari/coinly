import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Analytics",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.large,
          fontWeightVariant: FontWeightVariant.bold,
        ),
      ),
    );
  }
}
