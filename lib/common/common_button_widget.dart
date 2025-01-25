import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onPressed;
  final String btnLabel;
  final TextStyle? btnLabelStyle;
  final Color? backgroundColor;
  const CommonButtonWidget({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    required this.btnLabel,
    this.btnLabelStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 36.h,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(backgroundColor ?? AppColors.white),
        ),
        child: Text(
          btnLabel,
          style: btnLabelStyle ??
              AppTextStyles.getStyle(
                colorVariant: ColorVariant.black,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.medium,
              ),
        ),
      ),
    );
  }
}
