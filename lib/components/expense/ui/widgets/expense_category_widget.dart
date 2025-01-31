import 'package:coinly/components/common/common_elevated_button_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  final Function(int index) onPressedSelectedData;
  const ExpenseCategoryWidget({super.key, required this.onPressedSelectedData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return CommonElevatedButtonWidget(
              onPressed: () {
                onPressedSelectedData(index);
              },
              label: Text(
                "Electricity",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.mediumSmall,
                  fontWeightVariant: FontWeightVariant.medium,
                ),
              ),
              backgroundColor: AppColors.secondaryBlue,
              icon: Icon(
                Icons.electric_bolt_rounded,
                color: AppColors.white,
                size: 16.r,
              ),
            );
          },
          separatorBuilder: (context, index) => CommonSizedBoxWidget.width(8.w),
          itemCount: 4),
    );
  }
}
