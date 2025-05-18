import 'package:coinly/features/auth/bloc/auth_bloc.dart';
import 'package:coinly/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:coinly/features/auth/presentation/widgets/social_login_widget.dart';
import 'package:coinly/core/common/common_button_widget.dart';
import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/router/router_constant.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:coinly/core/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Screen for user sign-in functionality.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    _unfocusNodes();
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _unfocusNodes() {
    _emailFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocusNodes,
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20.r),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeader(),
                      CommonSizedBoxWidget.height(32.h),
                      _buildSignInForm(state),
                      CommonSizedBoxWidget.height(24.h),
                      const OrDividerWidget(),
                      CommonSizedBoxWidget.height(24.h),
                      SocialLoginWidget(authBloc: _authBloc),
                      CommonSizedBoxWidget.height(24.h),
                      _buildSignUpLink(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      AppStrings.loginToYourAccount,
      style: AppTextStyles.getStyle(
        colorVariant: ColorVariant.white,
        sizeVariant: SizeVariant.extraLarge,
        fontWeightVariant: FontWeightVariant.bold,
      ),
    );
  }

  Widget _buildSignInForm(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailField(),
          CommonSizedBoxWidget.height(16.h),
          _buildPasswordField(state),
          CommonSizedBoxWidget.height(16.h),
          _buildSignInButton(),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return CommonInputWidget(
      controller: _authBloc.emailController,
      borderRadius: BorderRadius.circular(8.r),
      focusNode: _emailFocusNode,
      fillColor: AppColors.secondaryBlue.withOpacity(.5),
      isFilled: true,
      hintText: AppStrings.email,
      prefixIcon: _buildEmailIcon(),
      textInputType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      validator: AppUtils.validateEmail,
    );
  }

  Widget _buildEmailIcon() {
    return ImagePreview(
      path: AppAssets.email,
      fit: BoxFit.contain,
      color:
          _emailFocusNode.hasFocus || _authBloc.emailController.text.isNotEmpty
              ? AppColors.white
              : AppColors.primaryGrey,
    );
  }

  Widget _buildPasswordField(AuthState state) {
    return CommonInputWidget(
      controller: _authBloc.passwordController,
      onChanged: (_) => _authBloc.add(PasswordInputEvent()),
      borderRadius: BorderRadius.circular(8.r),
      focusNode: _passwordFocusNode,
      fillColor: AppColors.secondaryBlue.withOpacity(.5),
      isFilled: true,
      hintText: AppStrings.password,
      prefixIcon: _buildPasswordIcon(),
      suffixIcon: _buildPasswordVisibilityToggle(state),
      obscureText: state.isObscureText,
      validator: AppUtils.validatePassword,
    );
  }

  Widget _buildPasswordIcon() {
    return ImagePreview(
      path: AppAssets.auth,
      fit: BoxFit.contain,
      color: _passwordFocusNode.hasFocus ||
              _authBloc.passwordController.text.isNotEmpty
          ? AppColors.white
          : AppColors.primaryGrey,
    );
  }

  Widget _buildPasswordVisibilityToggle(AuthState state) {
    if (_authBloc.passwordController.text.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onLongPress: () => _authBloc.add(HandleObscureTextChangeEvent()),
      onLongPressUp: () => _authBloc.add(HandleObscureTextChangeEvent()),
      child: ImagePreview(
        path: state.isObscureText ? AppAssets.eye : AppAssets.eyeCrossed,
        fit: BoxFit.contain,
        color: AppColors.primaryWhite,
      ),
    );
  }

  Widget _buildSignInButton() {
    return CommonButtonWidget(
      onPressed: _handleSignIn,
      width: MediaQuery.of(context).size.width,
      btnLabel: AppStrings.signIn,
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      _unfocusNodes();
      GoRouter.of(context).goNamed(RouterConstant.dashboardScreen);
    }
  }

  Widget _buildSignUpLink() {
    return InkWell(
      onTap: () {
        _unfocusNodes();
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
    );
  }
}
