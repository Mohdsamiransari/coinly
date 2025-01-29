import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({super.key});

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
            Text(
              AppStrings.totalBalance,
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryWhite,
                sizeVariant: SizeVariant.small,
                fontWeightVariant: FontWeightVariant.medium,
              ),
            ),
            CommonSizedBoxWidget.height(8.h),
            Text(
              "\$74,348",
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.extraLarge,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
          ],
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
          _buildInfoColumn(AppStrings.totalDebit, "-\$1,248"),
          _buildInfoColumn(AppStrings.totalCredit, "+\$3,248"),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
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
        Text(
          value,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
      ],
    );
  }
}
