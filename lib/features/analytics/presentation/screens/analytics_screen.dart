import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/analytics_bloc.dart';
import '../widgets/search_bar_with_filter.dart';
import '../widgets/filter_bottom_sheet.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalyticsBloc()..add(LoadAnalyticsEvent()),
      child: _AnalyticsScreenContent(),
    );
  }
}

class _AnalyticsScreenContent extends StatefulWidget {
  @override
  State<_AnalyticsScreenContent> createState() =>
      _AnalyticsScreenContentState();
}

class _AnalyticsScreenContentState extends State<_AnalyticsScreenContent> {
  int? selectedMonth;
  String? selectedCategory;
  double minPrice = 0;
  double maxPrice = 1000;
  String searchQuery = '';

  final TextEditingController _searchController = TextEditingController();

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final List<String> categories = [
    'Food',
    'Transport',
    'Entertainment',
    'Shopping',
    'Bills'
  ];

  void _openFilterSheet() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) => FilterBottomSheet(
        initialMonth: selectedMonth,
        initialCategory: selectedCategory,
        initialMinPrice: minPrice,
        initialMaxPrice: maxPrice,
        onApply: (month, category, min, max) {
          setState(() {
            selectedMonth = month;
            selectedCategory = category;
            minPrice = min;
            maxPrice = max;
          });
          _dispatchFilter(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        title: Text(
          "Budget Analytics",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.large,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The rest of the analytics widgets (existing code)
                if (state is AnalyticsLoaded) ...[
                  Builder(
                    builder: (context) {
                      final percent = (state.totalSpent / state.totalBudget)
                          .clamp(0.0, 1.0);
                      final savings = state.totalBudget - state.totalSpent;
                      final savingsPercent =
                          (savings / state.totalBudget).clamp(0.0, 1.0);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SearchBarWithFilter(
                            controller: _searchController,
                            onSearchChanged: (val) {
                              setState(() => searchQuery = val);
                              _dispatchFilter(context);
                            },
                            onFilterTap: _openFilterSheet,
                          ),
                          SizedBox(height: 24),
                          // Savings Overview
                          Card(
                            color: Colors.green[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Savings",
                                        style: AppTextStyles.getStyle(
                                          colorVariant: ColorVariant.white,
                                          sizeVariant: SizeVariant.medium,
                                          fontWeightVariant:
                                              FontWeightVariant.semiBold,
                                        ),
                                      ),
                                      Text(
                                        "₹${savings.toStringAsFixed(2)}",
                                        style: AppTextStyles.getStyle(
                                          colorVariant: ColorVariant.white,
                                          sizeVariant: SizeVariant.mediumLarge,
                                          fontWeightVariant:
                                              FontWeightVariant.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${(savingsPercent * 100).toStringAsFixed(1)}% saved",
                                        style: AppTextStyles.getStyle(
                                          colorVariant:
                                              ColorVariant.primaryGrey,
                                          sizeVariant: SizeVariant.mediumSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Budget",
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.primaryGrey,
                                      sizeVariant: SizeVariant.medium,
                                    ),
                                  ),
                                  Text(
                                    "₹${state.totalBudget.toStringAsFixed(2)}",
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.mediumLarge,
                                      fontWeightVariant: FontWeightVariant.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total Spent",
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.primaryGrey,
                                      sizeVariant: SizeVariant.medium,
                                    ),
                                  ),
                                  Text(
                                    "₹${state.totalSpent.toStringAsFixed(2)}",
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.mediumLarge,
                                      fontWeightVariant: FontWeightVariant.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          LinearProgressIndicator(
                            value: percent,
                            minHeight: 10,
                            backgroundColor: Colors.grey[800],
                            color: percent > 0.8 ? Colors.red : Colors.green,
                          ),
                          SizedBox(height: 32),
                          // Category Spending Breakdown
                          Text(
                            "Category Spending",
                            style: AppTextStyles.getStyle(
                              colorVariant: ColorVariant.white,
                              sizeVariant: SizeVariant.medium,
                              fontWeightVariant: FontWeightVariant.semiBold,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...state.categorySpending.entries.map((entry) {
                            final category = entry.key;
                            final spent = entry.value;
                            final budget = state.categoryBudgets[category] ?? 1;
                            final percent = (spent / budget).clamp(0.0, 1.0);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        category,
                                        style: AppTextStyles.getStyle(
                                          colorVariant:
                                              ColorVariant.primaryGrey,
                                          sizeVariant: SizeVariant.medium,
                                        ),
                                      ),
                                      Text(
                                        "₹${spent.toStringAsFixed(0)} / ₹${budget.toStringAsFixed(0)}",
                                        style: AppTextStyles.getStyle(
                                          colorVariant: ColorVariant.white,
                                          sizeVariant: SizeVariant.mediumSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: percent,
                                    minHeight: 8,
                                    backgroundColor: Colors.grey[800],
                                    color: percent > 0.8
                                        ? Colors.red
                                        : Colors.blueAccent,
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 32),
                          // Monthly Trend
                          Text(
                            "Monthly Trend",
                            style: AppTextStyles.getStyle(
                              colorVariant: ColorVariant.white,
                              sizeVariant: SizeVariant.medium,
                              fontWeightVariant: FontWeightVariant.semiBold,
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                                  List.generate(state.monthlyTrend.length, (i) {
                                final max = state.monthlyTrend
                                    .reduce((a, b) => a > b ? a : b);
                                final value = state.monthlyTrend[i];
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: (value / max) * 80,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "M${i + 1}",
                                          style: AppTextStyles.getStyle(
                                            colorVariant:
                                                ColorVariant.primaryGrey,
                                            sizeVariant: SizeVariant.small,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 32),
                          // Top Expenses
                          Text(
                            "Top Expenses",
                            style: AppTextStyles.getStyle(
                              colorVariant: ColorVariant.white,
                              sizeVariant: SizeVariant.medium,
                              fontWeightVariant: FontWeightVariant.semiBold,
                            ),
                          ),
                          SizedBox(height: 16),
                          ...state.topExpenses.map((expense) => Card(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  title: Text(
                                    expense['name'],
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.medium,
                                      fontWeightVariant:
                                          FontWeightVariant.semiBold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    expense['date'],
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.primaryGrey,
                                      sizeVariant: SizeVariant.small,
                                    ),
                                  ),
                                  trailing: Text(
                                    "₹${expense['amount']}",
                                    style: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.medium,
                                      fontWeightVariant: FontWeightVariant.bold,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(height: 32),
                          // Weekly Spending (existing bar chart)
                          Text(
                            "Weekly Spending",
                            style: AppTextStyles.getStyle(
                              colorVariant: ColorVariant.white,
                              sizeVariant: SizeVariant.medium,
                              fontWeightVariant: FontWeightVariant.semiBold,
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(
                                  state.weeklySpending.length, (i) {
                                final max = state.weeklySpending
                                    .reduce((a, b) => a > b ? a : b);
                                final value = state.weeklySpending[i];
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: (value / max) * 80,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          "Day ${i + 1}",
                                          style: AppTextStyles.getStyle(
                                            colorVariant:
                                                ColorVariant.primaryGrey,
                                            sizeVariant: SizeVariant.small,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: 60.h,)
                        ],
                      );
                    },
                  ),
                ] else ...[
                  const Center(child: CircularProgressIndicator()),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _dispatchFilter(BuildContext context) {
    context.read<AnalyticsBloc>().add(
      FilterAnalyticsEvent(
        monthIndex: selectedMonth,
        category: selectedCategory,
        minPrice: minPrice,
        maxPrice: maxPrice,
        searchQuery: searchQuery,
      ),
    );
  }
}
