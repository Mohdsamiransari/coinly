import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 16.r,
          ),
        ),
        title: Text(
          'About',
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.mediumLarge,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coinly',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.large,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Coinly is your all-in-one personal finance and expense tracking app. Easily manage your spending, set budgets, and gain insights into your financial habits. Secure, intuitive, and designed to help you achieve your financial goals.',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Version 1.0.0',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.small,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
