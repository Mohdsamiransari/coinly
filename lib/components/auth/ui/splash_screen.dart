import 'package:coinly/router/router_constant.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
    _authenticateAndRoute();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _authenticateAndRoute() {
    Future.delayed(const Duration(seconds: 6), () {
      return GoRouter.of(context).goNamed(RouterConstant.signInScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
      ),
    );
  }
}
