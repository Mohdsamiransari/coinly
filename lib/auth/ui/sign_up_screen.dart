import 'package:coinly/common/common_button_widget.dart';
import 'package:coinly/common/common_input_widget.dart';
import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/common/image_preview.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height, // Match screen height
            alignment: Alignment.center,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.createNewAccount,
                  style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.extraLarge,
                      fontWeightVariant: FontWeightVariant.bold),
                ),
                CommonSizedBoxWidget.height(32.h),
                CommonInputWidget(
                  fillColor: AppColors.secondaryBlue.withOpacity(.5),
                  isFilled: true,
                  hintText: AppStrings.userName,
                  prefixIcon:
                      // Icon(Icons.email)
                      ImagePreview(
                    path: "assets/images/email white.png",
                    width: 24.h,
                    height: 24.w,
                  ),
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  fillColor: AppColors.secondaryBlue.withOpacity(.5),
                  isFilled: true,
                  hintText: AppStrings.email,
                  prefixIcon: ImagePreview(
                    path: "assets/images/email white.png",
                    width: 24.h,
                    height: 24.w,
                  ),
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  fillColor: AppColors.secondaryBlue.withOpacity(.5),
                  isFilled: true,
                  hintText: AppStrings.password,
                  prefixIcon: ImagePreview(
                    path: "assets/images/shield white.png",
                    width: 24.r,
                    height: 24.r,
                  ),
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonButtonWidget(
                  onPressed: () {},
                  btnLabel: AppStrings.signUp,
                ),
                CommonSizedBoxWidget.height(24.h),
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
                CommonSizedBoxWidget.height(24.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.r),
                      child: IconButton(
                        onPressed: () {},
                        icon: const ImagePreview(
                          path: AppAssets.emailWhite,
                          color: Colors.black,
                        ),
                        color: Colors.white,
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(Size(50.r, 50.r)),
                          backgroundColor:
                              WidgetStateProperty.all(Colors.white),
                          shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CommonSizedBoxWidget.height(24.h),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).goNamed(RouterConstant.signInScreen);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAnAccount,
                      style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.primaryWhite,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.regular,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.signIn,
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
        ),
      ),
    );
  }
}
