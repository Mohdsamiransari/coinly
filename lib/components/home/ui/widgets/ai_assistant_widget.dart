import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AiAssistantWidget extends StatelessWidget {
  const AiAssistantWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppStrings.aiAssistant,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque varius erat in neque feugiat eleifend at et nisi. Duis fermentum ex in dignissim molestie.",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.small,
                  fontWeightVariant: FontWeightVariant.medium,
                ),
              );
            },
            separatorBuilder: (context, index) =>
                CommonSizedBoxWidget.height(4.h),
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}
