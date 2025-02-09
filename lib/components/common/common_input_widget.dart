import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonInputWidget extends StatefulWidget {
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
  final Function()? onTap;
  final bool? readOnly;
  final String? initialValue;
  final String? Function(String?)? validator;
  final FocusNode? focusNode; // <-- Added focusNode parameter
  final Function(bool)? onFocusChange; // Callback for focus state

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
    this.onTap,
    this.readOnly,
    this.initialValue,
    this.validator,
    this.focusNode, // <-- Accept external FocusNode
    this.onFocusChange, // Callback for focus change
  });

  @override
  State<CommonInputWidget> createState() => _CommonInputWidgetState();
}

class _CommonInputWidgetState extends State<CommonInputWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (widget.onFocusChange != null) {
        widget.onFocusChange!(_focusNode.hasFocus);
      }
      setState(() {}); // Rebuild when focus changes
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode, // <-- Assign focus node
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      readOnly: widget.readOnly ?? false,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      keyboardType: widget.textInputType,
      style: widget.textStyle ??
          AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.medium,
          ),
      obscureText: widget.obscureText,
      textCapitalization:
          widget.textCapitalization ?? TextCapitalization.sentences,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding:
            widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w),
        fillColor: widget.fillColor,
        filled: widget.isFilled,
        hintText: widget.hintText,
        hintStyle: widget.hintTextStyle ??
            AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: BoxConstraints(
          maxWidth: 34.r,
          maxHeight: 20.r,
        ),
        prefixText: widget.prefixText,
        suffixIcon: widget.suffixIcon,
        suffixText: widget.suffixText,
        suffixIconConstraints: BoxConstraints(
          maxWidth: 34.r,
          maxHeight: 20.r,
        ),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(25.r),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8.r),
          borderSide: widget.borderSide ?? BorderSide.none,
        ),
      ),
    );
  }
}
