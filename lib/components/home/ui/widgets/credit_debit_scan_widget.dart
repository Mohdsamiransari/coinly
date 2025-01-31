import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_elevated_button_widget.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreditDebitScanWidget extends StatelessWidget {
  const CreditDebitScanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CommonElevatedButtonWidget(
          onPressed: () {
            GoRouter.of(context)
                .pushNamed(RouterConstant.debitCreditExpenseScreen, extra: {
              "isDebitScreen": true,
            });
          },
          label: Text(
            "Debit",
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.black,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          icon: Icon(
            Icons.arrow_outward_rounded,
            size: 24.r,
            color: AppColors.black,
          ),
        ),
        CommonSizedBoxWidget.width(8.h),
        CommonElevatedButtonWidget(
          onPressed: () {
            GoRouter.of(context)
                .pushNamed(RouterConstant.debitCreditExpenseScreen, extra: {
              "isDebitScreen": false,
            });
          },
          backgroundColor: AppColors.secondaryBlue,
          label: Text(
            "Credit",
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          icon: RotatedBox(
            quarterTurns: 90,
            child: Icon(
              Icons.arrow_outward_rounded,
              size: 24.r,
              color: AppColors.white,
            ),
          ),
        ),
        CommonSizedBoxWidget.width(8.h),
        CommonButtonWidget(
          backgroundColor: AppColors.secondaryBlue,
          width: 38.r,
          height: 38.r,
          btnChild: Icon(
            Icons.qr_code_2_rounded,
            size: 24.r,
            color: AppColors.white,
          ),
        ),
        CommonSizedBoxWidget.width(8.h),
        CommonButtonWidget(
          backgroundColor: AppColors.secondaryBlue,
          width: 38.r,
          height: 38.r,
          btnChild: Icon(
            Icons.qr_code_scanner_rounded,
            size: 24.r,
            color: AppColors.white,
          ),
        )
      ],
    );
  }
}
