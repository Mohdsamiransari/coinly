import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNotificationWidget extends StatelessWidget {
  const UserNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.white,
          child: Icon(Icons.person),
        ),
        CommonSizedBoxWidget.width(8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Jacob Lee",
              style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.bold),
            ),
            Text(
              "jacoblee@gmail.com",
              style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.primaryWhite,
                  sizeVariant: SizeVariant.small,
                  fontWeightVariant: FontWeightVariant.regular),
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.notifications,
          size: 24.r,
          color: AppColors.white,
        )
      ],
    );
  }
}
