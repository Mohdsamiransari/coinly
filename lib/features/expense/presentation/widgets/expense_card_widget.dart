import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/common/stacked_avatar_widget.dart';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/core/router/router_constant.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:coinly/features/expense/data/model/expense_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExpenseCardWidget extends StatelessWidget {
  final Data transaction;
  final bool? isStackedAvatar;
  const ExpenseCardWidget(
      {super.key, required this.transaction, this.isStackedAvatar = false});

  @override
  Widget build(BuildContext context) {
    final result = AppHelpers.dateTimeFunction(transaction.expenseDate ?? "");
    final amountType = transaction.expenseType == "debit" ? "-" : "+";
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
              transaction.expenseName ?? "",
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
          if (isStackedAvatar == true) ...[
            CommonSizedBoxWidget.width(8.w),
            const StackedAvatarWidget()
          ]
        ],
      ),
      subtitle: Text(
        "${result.date} - ${result.time}",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.primaryWhite,
          sizeVariant: SizeVariant.small,
          fontWeightVariant: FontWeightVariant.medium,
        ),
      ),
      trailing: Text(
        "$amountType\$${transaction.expenseAmount?.toStringAsFixed(2)}",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.mediumLarge,
          fontWeightVariant: FontWeightVariant.semiBold,
        ),
      ),
    );
  }
}
