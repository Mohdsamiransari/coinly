import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/stacked_avatar_widget.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ExpenseCardShimmer extends StatelessWidget {
  const ExpenseCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryWhite.withOpacity(0.1),
      highlightColor: AppColors.white.withOpacity(0.3),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        minTileHeight: 40.h,
        leading: Container(
          height: 30.h,
          width: 30.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                "Expense",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            CommonSizedBoxWidget.width(8.w),
            const StackedAvatarWidget()
          ],
        ),
        subtitle: Text(
          "Loading expense details...",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.primaryWhite,
            sizeVariant: SizeVariant.small,
            fontWeightVariant: FontWeightVariant.medium,
          ),
        ),
        trailing: Text(
          "-\$0.00",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.mediumLarge,
            fontWeightVariant: FontWeightVariant.semiBold,
          ),
        ),
      ),
    );
  }
}
