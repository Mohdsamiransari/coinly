import 'dart:developer';

import 'package:coinly/core/common/common_button_widget.dart';
import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/common/stacked_avatar_widget.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
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
          AppStrings.expenseDetail,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.mediumLarge,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          CommonButtonWidget(
            onPressed: () {
              log("Expense Edit");
            },
            btnChild: ImagePreview(
              path: AppAssets.edit,
              width: 16.r,
              height: 16.r,
              color: AppColors.primaryWhite,
            ),
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
              decoration: BoxDecoration(
                color: AppColors.secondaryBlue,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.expenseSplitWith,
                    style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.medium,
                      fontWeightVariant: FontWeightVariant.bold,
                    ),
                  ),
                  const StackedAvatarWidget()
                ],
              ),
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonInputWidget(
              isFilled: true,
              fillColor: AppColors.secondaryBlue,
              borderRadius: BorderRadius.circular(8.r),
              hintText: AppStrings.otherDetails,
            ),
          ],
        ),
      ),
    );
  }
}
