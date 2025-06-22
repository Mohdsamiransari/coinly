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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(GetTotalBalanceEvent());
    _controllers = List.generate(6, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
      );
    });

    _slideAnimations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(0, -0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(controller);
    }).toList();

    _startAnimations();
    searchFocusNode.addListener(() => setState(() {}));
  }

  void _startAnimations() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 200));
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    searchFocusNode.dispose();
    super.dispose();
  }

  Widget _buildAnimatedWidget({required Widget child, required int index}) {
    return AnimatedBuilder(
      animation: _controllers[index],
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimations[index],
          child: SlideTransition(
            position: _slideAnimations[index],
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = context.read<HomeBloc>();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Notification
                _buildAnimatedWidget(
                    child: const UserNotificationWidget(), index: 0),
                CommonSizedBoxWidget.height(24.h),
                // Search Bar
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Amount Card
                        _buildAnimatedWidget(
                            child: AmountCardWidget(
                              homeBloc: homeBloc,
                            ),
                            index: 2),
                        CommonSizedBoxWidget.height(16.h),
                        // Credit Debit Scan
                        _buildAnimatedWidget(
                            child: const CreditDebitScanWidget(), index: 3),

                        CommonSizedBoxWidget.height(16.h),
                        // AI Assistant
                        //   _buildAnimatedWidget(
                        //       child: const AiAssistantWidget(), index: 4),

                        //  CommonSizedBoxWidget.height(16.h),
                        // Recent Transaction
                        // _buildAnimatedWidget(
                        //     child: const RecentTransactionWidget(), index: 5),
                        // CommonSizedBoxWidget.height(50.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
