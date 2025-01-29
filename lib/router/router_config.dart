import 'package:coinly/components/auth/ui/sign_in_screen.dart';
import 'package:coinly/components/auth/ui/sign_up_screen.dart';
import 'package:coinly/components/auth/ui/splash_screen.dart';
import 'package:coinly/components/dashboard/ui/dashboard_screen.dart';
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
    ),
    GoRoute(
      path: "/signUpScreen",
      name: RouterConstant.signUpScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SignUpScreen());
      },
    ),
    GoRoute(
      path: "/dashboardScreen",
      name: RouterConstant.dashboardScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: DashboardScreen());
      },
    ),

  ]);
}
