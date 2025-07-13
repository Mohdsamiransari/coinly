import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          title,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.primaryGrey,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.semiBold,
          ),
        ),
        SizedBox(height: 8.h),
        ...children,
      ],
    );
  }
} 