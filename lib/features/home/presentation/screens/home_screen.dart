import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/home/bloc/home_bloc.dart';
import 'package:coinly/features/home/presentation/widgets/ai_assistant_widget.dart';
import 'package:coinly/features/home/presentation/widgets/amount_card_widget.dart';
import 'package:coinly/features/home/presentation/widgets/credit_debit_scan_widget.dart';
import 'package:coinly/features/expense/presentation/widgets/recent_transaction_widget.dart';
import 'package:coinly/features/home/presentation/widgets/user_notification_widget.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<Offset>> _slideAnimations;
  final FocusNode searchFocusNode = FocusNode();
  late final HomeBloc _homeBloc;

  static const int _animatedItemCount = 5; // Number of animated widgets

  @override
  void initState() {
    super.initState();
    _homeBloc = context.read<HomeBloc>()..add(GetTotalBalanceEvent());
    context.read<ExpenseBloc>().add(GetRecentTransactionsEvent());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimations = List.generate(_animatedItemCount, (index) {
      final start = index * 0.15;
      final end = start + 0.5;
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end > 1.0 ? 1.0 : end, curve: Curves.easeOut),
      );
    });
    _slideAnimations = List.generate(_animatedItemCount, (index) {
      final start = index * 0.15;
      final end = start + 0.5;
      return Tween<Offset>(
        begin: const Offset(0, -0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end > 1.0 ? 1.0 : end, curve: Curves.easeOut),
      ));
    });
    _controller.forward();
    searchFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  Widget _buildAnimatedWidget({required Widget child, required int index}) {
    return FadeTransition(
      opacity: _fadeAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {},
        ),
        BlocListener<ExpenseBloc, ExpenseState>(
          listener: (context, state) {},
        )
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(18.r),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAnimatedWidget(
                        child: const UserNotificationWidget(),
                        index: 0,
                      ),
                      CommonSizedBoxWidget.height(24.h),
                      _buildAnimatedWidget(
                        child: CommonInputWidget(
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
                        index: 1,
                      ),
                      CommonSizedBoxWidget.height(16.h),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildAnimatedWidget(
                    child: AmountCardWidget(homeBloc: _homeBloc),
                    index: 2,
                  ),
                ),
                 SliverToBoxAdapter(
                  child: CommonSizedBoxWidget.height(16.h),
                ),
                SliverToBoxAdapter(
                  child: _buildAnimatedWidget(
                    child: const CreditDebitScanWidget(),
                    index: 3,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CommonSizedBoxWidget.height(16.h),
                ),
                SliverToBoxAdapter(
                  child: _buildAnimatedWidget(
                    child: const RecentTransactionWidget(),
                    index: 4,
                  ),
                ),
                SliverToBoxAdapter(
                  child: CommonSizedBoxWidget.height(50.h),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
