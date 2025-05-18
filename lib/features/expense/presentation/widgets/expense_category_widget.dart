import 'package:coinly/core/common/common_elevated_button_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ExpenseCategoryWidget extends StatelessWidget {
  final ExpenseState state;
  const ExpenseCategoryWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.getExpenseCategory.isLoading) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            3,
            (index) => Container(
              height: 35.h,
              margin: EdgeInsets.only(right: index != 2 ? 8.w : 0),
              child: CommonElevatedButtonWidget(
                label: Shimmer.fromColors(
                  baseColor: AppColors.white,
                  highlightColor: AppColors.secondaryBlue,
                  child: Text(
                    "expense",
                    style: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.white,
                      sizeVariant: SizeVariant.mediumSmall,
                      fontWeightVariant: FontWeightVariant.medium,
                    ),
                  ),
                ),
                border: Border.all(color: AppColors.white),
                backgroundColor: AppColors.secondaryBlue,
                icon: Icon(
                  Icons.electric_bolt_rounded,
                  color: AppColors.white,
                  size: 16.r,
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (state.getExpenseCategory.isError) {
      return AppHelpers.buildErrorWidget(
          state.getExpenseCategory.error ?? "Error loading data");
    }
    if (state.getExpenseCategory.isEmpty) {
      return AppHelpers.buildEmptyWidget("No recent transactions available");
    }

    return SizedBox(
      height: 35.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final selectedExpense = state.selectedExpenseCategory.data ==
              state.getExpenseCategory.data?[index]["name"];
          return CommonElevatedButtonWidget(
            onPressed: () {
              context.read<ExpenseBloc>().add(SelectExpenseCategoryEvent(
                  category: state.getExpenseCategory.data?[index]["name"]));
            },
            label: Text(
              state.getExpenseCategory.data?[index]["name"],
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.mediumSmall,
                fontWeightVariant: FontWeightVariant.medium,
              ),
            ),
            border: Border.all(color: AppColors.white),
            backgroundColor:
                selectedExpense ? AppColors.secondaryBlue : Colors.transparent,
            icon: Icon(
              Icons.electric_bolt_rounded,
              color: AppColors.white,
              size: 16.r,
            ),
          );
        },
        separatorBuilder: (context, index) => CommonSizedBoxWidget.width(8.w),
        itemCount: state.getExpenseCategory.data?.length ?? 0,
      ),
    );
  }
}
