import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/expense/presentation/shimmer/expense_card_shimmer.dart';
import 'package:coinly/features/expense/data/model/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RecentTransactionWidget extends StatefulWidget {
  const RecentTransactionWidget({super.key});

  @override
  State<RecentTransactionWidget> createState() => _RecentTransactionWidgetState();
}

class _RecentTransactionWidgetState extends State<RecentTransactionWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ExpenseBloc>().add(GetRecentTransactionsEvent());

  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        final recentTransactionState = state.transactions;
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

        return Column(
          children: [
            AppHelpers.buildHeaderWidget(headingText: "Recent Transactions"),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recentTransactionState.data?.reversed.length,
              itemBuilder: (context, index) {
                final transactionData =
                    recentTransactionState.data?.reversed.toList()[index];
                return _buildTransactionItem(transactionData!);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      minTileHeight: 40.h,
      leading: CircleAvatar(
        backgroundColor: AppColors.secondaryBlue,
        radius: 22.r,
        child: ImagePreview(path: transaction.iconUrl),
      ),
      title: Text(
        transaction.title,
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.medium,
          fontWeightVariant: FontWeightVariant.semiBold,
        ),
      ),
      subtitle: Text(
        "${transaction.date} - ${transaction.time}",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.primaryWhite,
          sizeVariant: SizeVariant.small,
          fontWeightVariant: FontWeightVariant.medium,
        ),
      ),
      trailing: Text(
        "-\$${transaction.amount.toStringAsFixed(2)}",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.mediumLarge,
          fontWeightVariant: FontWeightVariant.semiBold,
        ),
      ),
    );
  }
}
