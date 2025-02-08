import 'dart:developer';

import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  List<String> signInIcons = [
    AppAssets.faceBook,
    AppAssets.google,
    AppAssets.apple
  ];

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() => setState(() {}));
    passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

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
                  AppStrings.loginToYourAccount,
                  style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.extraLarge,
                      fontWeightVariant: FontWeightVariant.bold),
                ),
                CommonSizedBoxWidget.height(32.h),
                CommonInputWidget(
                  borderRadius: BorderRadius.circular(8.r),
                  focusNode: emailFocusNode,
                  fillColor: AppColors.secondaryBlue.withOpacity(.5),
                  isFilled: true,
                  hintText: AppStrings.email,
                  prefixIcon: const ImagePreview(
                    path: AppAssets.email,
                    fit: BoxFit.contain,
                    color: AppColors.primaryGrey,
                  ),
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  borderRadius: BorderRadius.circular(8.r),
                  focusNode: passwordFocusNode,
                  fillColor: AppColors.secondaryBlue.withOpacity(.5),
                  isFilled: true,
                  hintText: AppStrings.password,
                  prefixIcon: ImagePreview(
                    path: AppAssets.auth,
                    fit: BoxFit.contain,
                    color: passwordFocusNode.hasFocus
                        ? AppColors.white
                        : AppColors.primaryGrey,
                  ),
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonButtonWidget(
                  onPressed: () {
                    GoRouter.of(context)
                        .goNamed(RouterConstant.dashboardScreen);
                  },
                  btnLabel: AppStrings.signIn,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: IconButton(
                          onPressed: () {
                            if (index == 0) {
                              log("FaceBook");
                            } else if (index == 1) {
                              log("Google");
                            } else {
                              log("Apple");
                            }
                          },
                          icon: ImagePreview(
                            path: signInIcons[index],
                            width: 24.r,
                            height: 24.r,
                            // color: Colors.black,
                          ),
                          color: Colors.white,
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(Size(50.r, 50.r)),
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
                ),
                CommonSizedBoxWidget.height(24.h),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).goNamed(RouterConstant.signUpScreen);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.dontHaveAccount,
                      style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.primaryWhite,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.regular,
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.signUp,
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
