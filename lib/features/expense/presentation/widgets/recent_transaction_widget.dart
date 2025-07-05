import 'dart:math';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/expense/presentation/shimmer/expense_card_shimmer.dart';
import 'package:coinly/features/expense/presentation/widgets/expense_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

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

        final transactionDatas = recentTransactionState.data?.data ?? [];

        final transactions = transactionDatas
            .sublist(0, min(transactionDatas.length, 10))
            .reversed
            .toList();

        return Column(
          children: [
            AppHelpers.buildHeaderWidget(headingText: "Recent Transactions"),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transactionData = transactions[index];
                return ExpenseCardWidget(
                  transaction: transactionData,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
