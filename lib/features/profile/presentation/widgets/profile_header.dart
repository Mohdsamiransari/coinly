import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_assets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32.r,
          backgroundImage: AssetImage(AppAssets.persons),
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jacob Lee',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.large,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'jacoblee@gmail.com',
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }
} 