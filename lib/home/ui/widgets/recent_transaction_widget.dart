import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppStrings.recentTransactions,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.semiBold,
          ),
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              minTileHeight: 40.h,
              leading: CircleAvatar(
                backgroundColor: AppColors.secondaryBlue,
                radius: 22.r,
                child: Icon(
                  Icons.fastfood_rounded,
                  size: 20.r,
                  color: AppColors.white,
                ),
              ),
              title: Text(
                "Electricity Bill",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
              ),
              subtitle: Text(
                "4 September - 8:30 pm",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.primaryWhite,
                  sizeVariant: SizeVariant.small,
                  fontWeightVariant: FontWeightVariant.medium,
                ),
              ),
              trailing: Text(
                "-\$150",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.mediumLarge,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
              CommonSizedBoxWidget.height(8.h),
          itemCount: 16,
        ),
      ],
    );
  }
}
