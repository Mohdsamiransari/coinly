import 'package:coinly/components/auth/ui/sign_in_screen.dart';
import 'package:coinly/components/auth/ui/sign_up_screen.dart';
import 'package:coinly/components/auth/ui/splash_screen.dart';
import 'package:coinly/components/dashboard/ui/dashboard_screen.dart';
import 'package:coinly/components/expense/ui/debit_credit_expense_screen.dart';
import 'package:coinly/components/friends/ui/friends_profile_screen.dart';
import 'package:coinly/components/friends/ui/search_friends_screen.dart';
import 'package:coinly/components/qr/ui/user_qr_code_screen.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterConfig {
  static final GoRouter router = GoRouter(routes: [
    // Auth
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

    // Dashboard
    GoRoute(
      path: "/dashboardScreen",
      name: RouterConstant.dashboardScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: DashboardScreen());
      },
    ),

    // Debit Credit

    GoRoute(
      path: "/debitCreditExpenseScreen",
      name: RouterConstant.debitCreditExpenseScreen,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return MaterialPage(
            child: DebitCreditExpenseScreen(
          isDebitScreen: data["isDebitScreen"],
        ));
      },
    ),

    // QR Code
    GoRoute(
      path: "/userQrCodeScreen",
      name: RouterConstant.userQrCodeScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: UserQrCodeScreen());
      },
    ),

    // Friends
    GoRoute(
      path: "/friendsProfileScreen",
      name: RouterConstant.friendsProfileScreen,
      pageBuilder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return MaterialPage(
            child: FriendsProfileScreen(
          friendEmail: data["friendEmail"],
          friendName: data["friendName"],
          friendProfileImage: data["friendProfileImage"],
        ));
      },
    ),
    GoRoute(
      path: "/searchFriendsScreen",
      name: RouterConstant.searchFriendsScreen,
      pageBuilder: (context, state) {
        return const MaterialPage(child: SearchFriendsScreen());
      },
    ),
  ]);
}
