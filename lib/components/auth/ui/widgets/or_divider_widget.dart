import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100.w,
          child: Divider(
            color: AppColors.primaryWhite,
            height: 1.h,
          ),
        ),
        CommonSizedBoxWidget.width(4.w),
        Text(
          "OR",
          style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.bold),
        ),
        CommonSizedBoxWidget.width(4.w),
        SizedBox(
          width: 100.w,
          child: Divider(
            color: AppColors.primaryWhite,
            height: 1.h,
          ),
        ),
      ],
    );
  }
}
