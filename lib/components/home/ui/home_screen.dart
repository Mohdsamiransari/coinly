import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/components/home/ui/widgets/ai_assistant_widget.dart';
import 'package:coinly/components/home/ui/widgets/amount_card_widget.dart';
import 'package:coinly/components/home/ui/widgets/credit_debit_scan_widget.dart';
import 'package:coinly/components/home/ui/widgets/recent_transaction_widget.dart';
import 'package:coinly/components/home/ui/widgets/user_notification_widget.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
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

    _controllers = List.generate(6, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
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
    return Padding(
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAnimatedWidget(child: const UserNotificationWidget(), index: 0),
          CommonSizedBoxWidget.height(24.h),
          _buildAnimatedWidget(
            child: CommonInputWidget(
              borderRadius: BorderRadius.circular(8.r),
              isFilled: true,
              focusNode: searchFocusNode,
              fillColor: AppColors.white,
              prefixIcon: ImagePreview(
                path: AppAssets.search,
                color: searchFocusNode.hasFocus ? AppColors.black: AppColors.primaryGrey,
              ),
              hintText: AppStrings.search,
              hintTextStyle: AppTextStyles.getStyle(
                colorVariant: ColorVariant.black,
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
                  _buildAnimatedWidget(
                      child: const AmountCardWidget(), index: 2),
                  CommonSizedBoxWidget.height(16.h),
                  _buildAnimatedWidget(
                      child: const CreditDebitScanWidget(), index: 3),
                  CommonSizedBoxWidget.height(16.h),
                  _buildAnimatedWidget(
                      child: const AiAssistantWidget(), index: 4),
                  CommonSizedBoxWidget.height(16.h),
                  _buildAnimatedWidget(
                      child: const RecentTransactionWidget(), index: 5),
                  CommonSizedBoxWidget.height(50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
