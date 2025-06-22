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
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Screen for user registration functionality.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _userNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onFocusChange);
    _userNameFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    _emailFocusNode.removeListener(_onFocusChange);
    _passwordFocusNode.removeListener(_onFocusChange);
    _userNameFocusNode.removeListener(_onFocusChange);
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _userNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state.register.isSuccess) {
              GoRouter.of(context).goNamed(RouterConstant.dashboardScreen);
            }
            if (state.register.isError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.register.error ?? ""),
                ),
              );
            }
        },
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
                    _buildSignUpForm(state),
                    CommonSizedBoxWidget.height(24.h),
                    const OrDividerWidget(),
                    CommonSizedBoxWidget.height(24.h),
                    SocialLoginWidget(authBloc: _authBloc),
                    CommonSizedBoxWidget.height(24.h),
                    _buildSignInLink(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      AppStrings.createNewAccount,
      style: AppTextStyles.getStyle(
        colorVariant: ColorVariant.white,
        sizeVariant: SizeVariant.extraLarge,
        fontWeightVariant: FontWeightVariant.bold,
      ),
    );
  }

  Widget _buildSignUpForm(AuthState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildUsernameField(),
          CommonSizedBoxWidget.height(16.h),
          _buildEmailField(),
          CommonSizedBoxWidget.height(16.h),
          _buildPasswordField(state),
          CommonSizedBoxWidget.height(16.h),
          _buildSignUpButton(),
        ],
      ),
    );
  }

  Widget _buildUsernameField() {
    return CommonInputWidget(
      controller: _authBloc.usernameController,
      borderRadius: BorderRadius.circular(8.r),
      focusNode: _userNameFocusNode,
      fillColor: AppColors.secondaryBlue.withOpacity(.5),
      isFilled: true,
      hintText: AppStrings.userName,
      prefixIcon: _buildUsernameIcon(),
      validator: _validateUsername,
    );
  }

  Widget _buildUsernameIcon() {
    return ImagePreview(
      path: AppAssets.circleUser,
      width: 100,
      fit: BoxFit.contain,
      color: _userNameFocusNode.hasFocus ||
              _authBloc.usernameController.text.isNotEmpty
          ? AppColors.white
          : AppColors.primaryGrey,
    );
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.userNameCannotBeEmpty;
    }
    if (value.length < 4) {
      return AppStrings.userNameTooShort;
    }
    return null;
  }

  Widget _buildEmailField() {
    return CommonInputWidget(
      controller: _authBloc.emailController,
      borderRadius: BorderRadius.circular(8.r),
      fillColor: AppColors.secondaryBlue.withOpacity(.5),
      isFilled: true,
      focusNode: _emailFocusNode,
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

  Widget _buildSignUpButton() {
    return CommonButtonWidget(
      onPressed: _handleSignUp,
      width: MediaQuery.of(context).size.width,
      btnLabel: AppStrings.signUp,
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.add(AuthRegisterEvent());
      // GoRouter.of(context).goNamed(RouterConstant.dashboardScreen);
    }
  }

  Widget _buildSignInLink() {
    return InkWell(
      onTap: () => GoRouter.of(context).goNamed(RouterConstant.signInScreen),
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
    );
  }
}
