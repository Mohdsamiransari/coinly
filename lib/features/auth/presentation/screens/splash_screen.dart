import 'dart:developer';

import 'package:coinly/core/router/router_constant.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:coinly/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<AuthBloc>()..add(AuthCheckLoggedIn());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  authenticateLogin(AuthState state) async {
    await Future.delayed(const Duration(seconds: 6));
    if (state.isLoggedIn == true) {
      GoRouter.of(context).goNamed(RouterConstant.dashboardScreen);
    } else if (state.isLoggedIn == false) {
      log("sdjfadklfs ${state.isLoggedIn}");
      return GoRouter.of(context).goNamed(RouterConstant.signInScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          authenticateLogin(state);
        },
        builder: (context, state) {
          return Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _animationController.value,
                  child: Text(
                    AppStrings.appName,
                    style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.white,
                        sizeVariant: SizeVariant.extraExtraLarge,
                        fontWeightVariant: FontWeightVariant.bold),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
