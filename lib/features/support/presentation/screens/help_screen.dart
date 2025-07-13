import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:go_router/go_router.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
          'Help',
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
              'Frequently Asked Questions',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.large,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
            SizedBox(height: 16.h),
            _buildFaq(
              context,
              'How do I add a new expense?',
              'Tap the "+" button on the home screen and fill in the details to add a new expense.',
            ),
            _buildFaq(
              context,
              'How can I set a budget?',
              'Go to the Budget section from the dashboard and set your monthly or weekly budget.',
            ),
            _buildFaq(
              context,
              'Is my data secure?',
              'Yes, your data is securely stored and only accessible by you.',
            ),
            _buildFaq(
              context,
              'How do I reset my password?',
              'Go to Profile > Password and security to reset your password.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaq(BuildContext context, String question, String answer) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.semiBold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            answer,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryGrey,
              sizeVariant: SizeVariant.mediumSmall,
              fontWeightVariant: FontWeightVariant.regular,
            ),
          ),
        ],
      ),
    );
  }
}
