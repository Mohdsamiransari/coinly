import 'dart:developer';

import 'package:coinly/common/common_button_widget.dart';
import 'package:coinly/common/common_input_widget.dart';
import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.loginToYourAccount,
              style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.extraLarge,
                  fontWeightVariant: FontWeightVariant.bold),
            ),
            CommonSizedBoxWidget.height(32.h),
            CommonInputWidget(
              fillColor: AppColors.secondaryBlue.withOpacity(.5),
              isFilled: true,
              hintText: "Email",
              prefixIcon: ImagePreview(
                path: AppAssets.emailWhite,
                width: 24.h,
                height: 24.w,
              ),
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonInputWidget(
              fillColor: AppColors.secondaryBlue.withOpacity(.5),
              isFilled: true,
              hintText: "Password",
              prefixIcon: ImagePreview(
                path: AppAssets.authWhite,
                width: 24.h,
                height: 24.w,
              ),
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonButtonWidget(
              onPressed: () {
                log("Sign In button pressed");
              },
              btnLabel: "Sign In",
            ),
            CommonSizedBoxWidget.height(32.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                  child: Divider(
                    color: AppColors.primaryWhite,
                    height: 1.h,
                  ),
                ),
                CommonSizedBoxWidget.width(4.w),
                Text(
                  "OR",
                  style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.primaryWhite,
                      sizeVariant: SizeVariant.medium,
                      fontWeightVariant: FontWeightVariant.bold),
                ),
                CommonSizedBoxWidget.width(4.w),
                SizedBox(
                  width: 100.w,
                  child: Divider(
                    color: AppColors.primaryWhite,
                    height: 1.h,
                  ),
                ),
              ],
            ),
            CommonSizedBoxWidget.height(32.h),
            InkWell(
              onTap: () {},
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  style: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.primaryWhite,
                    sizeVariant: SizeVariant.medium,
                    fontWeightVariant: FontWeightVariant.regular,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.white,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.medium,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
