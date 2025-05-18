import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

/// A shimmer loading widget that mimics the appearance of the AmountCardWidget.
class AmountCardShimmer extends StatelessWidget {
  const AmountCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopContainer(),
        _buildBottomContainer(),
      ],
    );
  }

  Widget _buildTopContainer() {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            CommonSizedBoxWidget.height(8.h),
            _buildBalanceShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.totalBalance,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.primaryWhite,
            sizeVariant: SizeVariant.small,
            fontWeightVariant: FontWeightVariant.medium,
          ),
        ),
        ImagePreview(
          path: AppAssets.edit,
          width: 12.r,
          height: 12.r,
          color: AppColors.primaryWhite,
        ),
      ],
    );
  }

  Widget _buildBalanceShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryWhite.withOpacity(0.1),
      highlightColor: AppColors.white.withOpacity(0.3),
      child: Text(
        "\$0.00",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.extraLarge,
          fontWeightVariant: FontWeightVariant.bold,
        ),
      ),
    );
  }

  Widget _buildBottomContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.tertiaryBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn(AppStrings.totalDebit),
          _buildInfoColumn(AppStrings.totalCredit),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.primaryWhite,
            sizeVariant: SizeVariant.small,
            fontWeightVariant: FontWeightVariant.medium,
          ),
        ),
        _buildValueShimmer(),
      ],
    );
  }

  Widget _buildValueShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryWhite.withOpacity(0.1),
      highlightColor: AppColors.white.withOpacity(0.3),
      child: Text(
        "\$0.00",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.medium,
          fontWeightVariant: FontWeightVariant.bold,
        ),
      ),
    );
  }
}
