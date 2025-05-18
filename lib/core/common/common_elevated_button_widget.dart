import 'package:coinly/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget? icon;
  final Color? backgroundColor;
  final BoxBorder? border;

  const CommonElevatedButtonWidget({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: label,
      icon: icon ?? const SizedBox.shrink(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
          side: border is Border
              ? (border as Border).top // assuming uniform border
              : BorderSide.none,
        ),
        // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        // elevation: 0,
      ),
    );
  }
}
