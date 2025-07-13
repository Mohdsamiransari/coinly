import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

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
          'Terms and Conditions',
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
        child: ListView(
          children: [
            Text(
              'Terms and Conditions',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.large,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'By using Coinly, you agree to the following terms and conditions:',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '1. You are responsible for maintaining the confidentiality of your account information.\n'
              '2. Coinly is not liable for any financial losses incurred while using the app.\n'
              '3. All data provided is for informational purposes only and should not be considered financial advice.\n'
              '4. We reserve the right to update these terms at any time.\n',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.mediumSmall,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'For more information, contact our support team.',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.mediumSmall,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
