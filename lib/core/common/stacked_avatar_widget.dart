import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class StackedAvatarWidget extends StatelessWidget {
  const StackedAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.h,
      width: 40.w,
      child: Stack(
        children: List.generate(
          3,
          (index) => Positioned(
            left: index * 12.0,
            child: CircleAvatar(
              backgroundColor: AppColors.secondaryBlue,
              radius: 8.r,
              child: const ImagePreview(
                path: "assets/images/expenseicon1.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
