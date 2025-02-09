import 'package:coinly/components/auth/bloc/auth_bloc.dart';
import 'package:coinly/components/auth/ui/widgets/or_divider_widget.dart';
import 'package:coinly/components/auth/ui/widgets/social_login_widget.dart';
import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:coinly/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.r),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height:
                    MediaQuery.of(context).size.height, // Match screen height
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
                    signUpForm(),
                    CommonSizedBoxWidget.height(24.h),
                    const OrDividerWidget(),
                    CommonSizedBoxWidget.height(24.h),
                    SocialLoginWidget(authBloc: authBloc),
                    CommonSizedBoxWidget.height(24.h),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context)
                            .goNamed(RouterConstant.signInScreen);
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
          );
        },
      ),
    );
  }

  Form signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CommonInputWidget(
            controller: authBloc.usernameController,
            borderRadius: BorderRadius.circular(8.r),
            focusNode: userNameFocusNode,
            fillColor: AppColors.secondaryBlue.withOpacity(.5),
            isFilled: true,
            hintText: AppStrings.userName,
            prefixIcon: ImagePreview(
              path: AppAssets.circleUser,
              width: 100,
              fit: BoxFit.contain,
              color: userNameFocusNode.hasFocus
                  ? AppColors.white
                  : AppColors.primaryGrey,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppStrings.userNameCannotBeEmpty;
              }
              if (value.length < 4) {
                return AppStrings.userNameTooShort;
              }
              return null;
            },
          ),
          CommonSizedBoxWidget.height(16.h),
          CommonInputWidget(
            controller: authBloc.emailController,
            borderRadius: BorderRadius.circular(8.r),
            fillColor: AppColors.secondaryBlue.withOpacity(.5),
            isFilled: true,
            focusNode: emailFocusNode,
            hintText: AppStrings.email,
            prefixIcon: ImagePreview(
              path: AppAssets.email,
              fit: BoxFit.contain,
              color: emailFocusNode.hasFocus
                  ? AppColors.white
                  : AppColors.primaryGrey,
            ),
            textInputType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            validator: AppUtils.validateEmail,
          ),
          CommonSizedBoxWidget.height(16.h),
          CommonInputWidget(
            controller: authBloc.passwordController,
            onChanged: (p0) {
              authBloc.add(PasswordInputEvent());
            },
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
            suffixIcon: GestureDetector(
              onLongPress: () {
                authBloc.add(HandleObscureTextChangeEvent());
              },
              onLongPressUp: () {
                authBloc.add(HandleObscureTextChangeEvent());
              },
              child: ImagePreview(
                path:
                    authBloc.obscureText ? AppAssets.eye : AppAssets.eyeCrossed,
                fit: BoxFit.contain,
                color: AppColors.primaryWhite,
              ),
            ),
            obscureText: authBloc.obscureText,
            validator: AppUtils.validatePassword,
          ),
          CommonSizedBoxWidget.height(16.h),
          CommonButtonWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                GoRouter.of(context).goNamed(RouterConstant.dashboardScreen);
              }
            },
            btnLabel: AppStrings.signUp,
          ),
        ],
      ),
    );
  }
}
