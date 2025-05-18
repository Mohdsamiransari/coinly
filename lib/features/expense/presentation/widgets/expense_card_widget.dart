import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/common/stacked_avatar_widget.dart';
import 'package:coinly/core/router/router_constant.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpenseCardWidget extends StatelessWidget {
  const ExpenseCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).pushNamed(RouterConstant.expenseDetailScreen);
      },
      contentPadding: EdgeInsets.zero,
      dense: true,
      minTileHeight: 40.h,
      leading: CircleAvatar(
        backgroundColor: AppColors.secondaryBlue,
        radius: 22.r,
        child: const ImagePreview(
          path: "assets/images/expenseicon1.png",
          fit: BoxFit.contain,
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              "Electricity Bill",
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
  }
}
