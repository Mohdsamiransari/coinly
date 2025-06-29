import 'dart:developer';

import 'package:coinly/core/common/common_bottomsheet_widget.dart';
import 'package:coinly/core/common/common_button_widget.dart';
import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/expense/presentation/shimmer/expense_card_shimmer.dart';
import 'package:coinly/features/expense/presentation/widgets/expense_card_widget.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  late final ExpenseBloc _expenseBloc;

  List<String> expenseType = [
    "All",
    "Electricity",
    "Groceries",
    "Home",
    "Travel",
    "Food",
    "Clothing",
    "Beauty"
  ];
  List<String> sortName = [
    "Ascending",
    "Descending",
    "Highest Price",
    "Lowest Price",
    "Newest",
    "Oldest",
  ];

  @override
  void initState() {
    super.initState();
    _expenseBloc = context.read<ExpenseBloc>()
      ..add(GetRecentTransactionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppStrings.history,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.mediumLarge,
              fontWeightVariant: FontWeightVariant.semiBold,
            ),
          ),
          CommonSizedBoxWidget.height(16.h),
          Row(
            children: [
              Expanded(
                child: CommonInputWidget(
                  controller: _searchController,
                  onChanged: (p0) {
                    _expenseBloc.add(FilterExpenseDataEvent(searchKeyword: p0));
                  },
                  borderRadius: BorderRadius.circular(24.r),
                  isFilled: true,
                  focusNode: searchFocusNode,
                  fillColor: AppColors.white,
                  prefixIcon: ImagePreview(
                    path: AppAssets.search,
                    width: 40.w,
                    color: searchFocusNode.hasFocus
                        ? AppColors.black
                        : AppColors.primaryGrey,
                  ),
                  hintText: AppStrings.search,
                  hintTextStyle: AppTextStyles.getStyle(
                    colorVariant: searchFocusNode.hasFocus
                        ? ColorVariant.black
                        : ColorVariant.primaryGrey,
                    sizeVariant: SizeVariant.medium,
                    fontWeightVariant: FontWeightVariant.medium,
                  ),
                ),
              ),
              CommonSizedBoxWidget.width(8.h),
              CommonButtonWidget(
                width: 42.r,
                height: 42.r,
                onPressed: () => filterBottomSheet(),
                btnChild: Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.white,
                  size: 24.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
                backgroundColor: AppColors.secondaryBlue,
              )
            ],
          ),
          CommonSizedBoxWidget.height(16.h),
          _buildExpenseList(),
        ],
      ),
    );
  }

  BlocBuilder<ExpenseBloc, ExpenseState> _buildExpenseList() {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        final recentTransactionState = state.transactions;
        final filteredTransactionsState = state.filteredTransactions;
        if (recentTransactionState.isLoading) {
          return const ExpenseCardShimmer();
        }
        if (recentTransactionState.isError) {
          return AppHelpers.buildErrorWidget(
              recentTransactionState.error ?? "Error loading data");
        }
        if (recentTransactionState.isEmpty) {
          return AppHelpers.buildEmptyWidget(
              "No recent transactions available");
        }

        // If filter is active (success or empty), use filtered results
        final isFiltering = filteredTransactionsState.isSuccess || filteredTransactionsState.isEmpty;
        final transactions = isFiltering
            ? (filteredTransactionsState.data ?? [])
            : (recentTransactionState.data?.data ?? []);
        final reversedTransactions = transactions.reversed.toList();

        if (isFiltering && reversedTransactions.isEmpty) {
          return AppHelpers.buildEmptyWidget("No transactions found for your search");
        }

        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final transactionData = reversedTransactions[index];
              return Column(
                children: [
                  ExpenseCardWidget(
                    transaction: transactionData,
                  ),
                  if (reversedTransactions.length - 1 == index)
                    CommonSizedBoxWidget.height(40.h), // Only for last item
                ],
              );
            },
            separatorBuilder: (context, index) =>
                CommonSizedBoxWidget.height(16.h),
            itemCount: reversedTransactions.length,
          ),
        );
      },
    );
  }

  void filterBottomSheet() {
    commonBottomSheetWidget(
      bgColor: AppColors.primaryWhite,
      barColor: AppColors.secondaryBlue,
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CommonButtonWidget(
                  height: 40.h,
                  btnLabel: expenseType[index],
                  btnLabelStyle: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.white,
                    sizeVariant: SizeVariant.mediumSmall,
                    fontWeightVariant: FontWeightVariant.medium,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  backgroundColor: AppColors.secondaryBlue,
                );
              },
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.width(8.w),
              itemCount: expenseType.length,
            ),
          ),
          CommonSizedBoxWidget.height(16.w),
          Text(
            "Sort by",
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primary,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          CommonSizedBoxWidget.height(16.w),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CommonButtonWidget(
                  height: 40.h,
                  btnLabel: sortName[index],
                  btnLabelStyle: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.white,
                    sizeVariant: SizeVariant.mediumSmall,
                    fontWeightVariant: FontWeightVariant.medium,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  backgroundColor: AppColors.secondaryBlue,
                );
              },
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.width(8.w),
              itemCount: sortName.length,
            ),
          ),
          CommonSizedBoxWidget.height(16.w),
          Text(
            "Amount",
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primary,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          FlutterSlider(
            values: const [300],
            max: 20000,
            min: 0,
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
              activeTrackBar: BoxDecoration(
                color: AppColors.secondaryBlue,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            handler: FlutterSliderHandler(
                decoration: const BoxDecoration(
                  color: AppColors.secondaryBlue,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.shrink()),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              log("Lower Value: $lowerValue");
              setState(() {});
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonButtonWidget(
                width: MediaQuery.of(context).size.width / 2.3,
                height: 40.h,
                btnLabel: "Cancel",
                btnLabelStyle: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.secondary,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                backgroundColor: AppColors.white,
              ),
              CommonButtonWidget(
                width: MediaQuery.of(context).size.width / 2.3,
                height: 40.h,
                btnLabel: "Apply",
                btnLabelStyle: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                backgroundColor: AppColors.secondaryBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
