import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButtonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Function()? onPressed;
  final String? btnLabel;
  final TextStyle? btnLabelStyle;
  final Color? backgroundColor;
  final Widget? btnChild;
  final AlignmentGeometry alignment;
  final EdgeInsets? padding;
  const CommonButtonWidget({
    super.key,
    this.width,
    this.height,
    this.onPressed,
    this.btnLabel,
    this.btnLabelStyle,
    this.backgroundColor,
    this.btnChild,
    this.alignment = Alignment.center,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 36.h,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
            backgroundColor:
                WidgetStatePropertyAll(backgroundColor ?? AppColors.white),
          ),
          child: Align(
            alignment: alignment,
            child: btnChild ??
                Text(
                  btnLabel ?? "",
                  style: btnLabelStyle ??
                      AppTextStyles.getStyle(
                        colorVariant: ColorVariant.black,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.medium,
                      ),
                ),
          )),
    );
  }
}
