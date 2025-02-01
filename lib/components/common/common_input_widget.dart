import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonInputWidget extends StatelessWidget {
  final Color? fillColor;
  final bool? isFilled;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextCapitalization? textCapitalization;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final String? suffixText;
  final Function(String)? onChanged;

  const CommonInputWidget({
    super.key,
    this.fillColor,
    this.isFilled,
    this.borderRadius,
    this.borderSide,
    this.controller,
    this.textStyle,
    this.obscureText = false,
    this.contentPadding,
    this.prefixIcon,
    this.prefixText,
    this.textCapitalization,
    this.hintText,
    this.hintTextStyle,
    this.textInputType,
    this.suffixIcon,
    this.suffixText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      onChanged: onChanged,
      keyboardType: textInputType,
      style: textStyle ??
          AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.medium,
          ),
      obscureText: obscureText,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
        fillColor: fillColor,
        filled: isFilled,
        hintText: hintText,
        hintStyle: hintTextStyle ??
            AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(25.r),
          borderSide: borderSide ?? BorderSide.none,
        ),
      ),
    );
  }
}
