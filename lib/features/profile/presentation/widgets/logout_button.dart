import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/utils/app_styles.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: InkWell(
        onTap: () async {
          final preference = await SharedPreferences.getInstance();
          preference.clear();
          context.go("/");
        },
        child: Row(
          children: [
            Icon(Icons.logout, color: Colors.red, size: 20.r),
            SizedBox(width: 12.w),
            Text(
              'Log out',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.error,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
