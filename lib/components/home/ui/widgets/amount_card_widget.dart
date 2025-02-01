import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _addBalanceModal(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          _buildTopContainer(),
          _buildBottomContainer(),
        ],
      ),
    );
  }

  _addBalanceModal(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryBlue,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  CommonSizedBoxWidget.height(8.h),
                  Text(
                    AppStrings.setYourCurrentBalance,
                    style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.medium,
                      fontWeightVariant: FontWeightVariant.medium,
                    ),
                  ),
                  CommonSizedBoxWidget.height(16.h),
                  CommonInputWidget(
                    isFilled: true,
                    fillColor: AppColors.white,
                    hintText: AppStrings.addYourCurrentBalance,
                    hintTextStyle: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.black,
                      sizeVariant: SizeVariant.medium,
                      fontWeightVariant: FontWeightVariant.medium,
                    ),
                  ),
                  CommonSizedBoxWidget.height(16.h),
                  CommonButtonWidget(
                    onPressed: () {},
                    btnLabel: AppStrings.add,
                  ),
                  CommonSizedBoxWidget.height(16.h),
                ],
              ),
            ),
          ),
        );
      },
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
