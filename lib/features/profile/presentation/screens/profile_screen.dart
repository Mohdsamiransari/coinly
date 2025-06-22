import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          final preference = await SharedPreferences.getInstance();
          preference.clear();
          context.go("/");
        },
        child: Text(
          "LogOut",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.large,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
      ),
    );
  }
}
