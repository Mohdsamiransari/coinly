import 'package:coinly/auth/ui/sign_in_screen.dart';
import 'package:coinly/auth/ui/splash_screen.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: "/",
      name: RouterConstant.splashScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SplashScreen());
      },
    ),
    GoRoute(
      path: "/signInScreen",
      name: RouterConstant.signInScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignInScreen());
      },
    )
  ]);
}
