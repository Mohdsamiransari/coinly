import 'package:coinly/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CommonElevatedButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget label;
  final Widget? icon;
  final Color? backgroundColor;

  const CommonElevatedButtonWidget({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: label,
      icon: icon,
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(backgroundColor ?? AppColors.white),
      ),
    );
  }
}
