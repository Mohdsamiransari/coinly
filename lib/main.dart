import 'package:coinly/components/auth/bloc/auth_bloc.dart';
import 'package:coinly/router/router_config.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Coinly',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryBlue,
            ),
            scaffoldBackgroundColor: AppColors.primaryBlue,
            useMaterial3: true,
          ),
          routeInformationParser: AppRouterConfig.router.routeInformationParser,
          routeInformationProvider:
              AppRouterConfig.router.routeInformationProvider,
          routerDelegate: AppRouterConfig.router.routerDelegate,
        ),
      ),
    );
  }
}
