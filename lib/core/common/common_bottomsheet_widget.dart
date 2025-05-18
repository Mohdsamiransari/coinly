import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void commonBottomSheetWidget(
    {required BuildContext context,
    required Widget child,
    Color? bgColor,
    Color? barColor}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.secondaryBlue,
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
                  color: barColor ?? Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              CommonSizedBoxWidget.height(8.h),
              child,
              CommonSizedBoxWidget.height(24.w),
            ],
          ),
        ),
      );
    },
  );
}
