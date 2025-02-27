import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AmountOweTextCardWidget extends StatelessWidget {
  final double amount;
  final String owedBy;
  const AmountOweTextCardWidget({
    super.key,
    required this.amount,
    required this.owedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "\$$amount\n",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.medium,
          fontWeightVariant: FontWeightVariant.medium,
        ),
        children: [
          TextSpan(
            text: owedBy,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
