import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Expense",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.large,
          fontWeightVariant: FontWeightVariant.bold,
        ),
      ),
    );
  }
}