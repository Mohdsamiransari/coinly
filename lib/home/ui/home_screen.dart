import 'package:coinly/common/common_input_widget.dart';
import 'package:coinly/common/common_sized_box_widget.dart';
import 'package:coinly/home/ui/widgets/ai_assistant_widget.dart';
import 'package:coinly/home/ui/widgets/amount_card_widget.dart';
import 'package:coinly/home/ui/widgets/credit_debit_scan_widget.dart';
import 'package:coinly/home/ui/widgets/recent_transaction_widget.dart';
import 'package:coinly/home/ui/widgets/user_notification_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isVisible = true; // Controls whether widgets are in the tree

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && _isVisible) {
      // Remove widgets when scrolling down
      setState(() {
        _isVisible = false;
      });
    } else if (_scrollController.offset <= 200 && !_isVisible) {
      // Re-add widgets when scrolling back to the top
      setState(() {
        _isVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserNotificationWidget(),
          CommonSizedBoxWidget.height(24.h),
          const CommonInputWidget(
            isFilled: true,
            fillColor: AppColors.white,
            prefixIcon: Icon(Icons.search_rounded),
            hintText: AppStrings.search,
          ),
          CommonSizedBoxWidget.height(16.h),
          // Content with scrollable section
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              // physics: _isVisible
              //     ? NeverScrollableScrollPhysics()
              //     : AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widgets above RecentTransactionWidget
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isVisible
                        ? Column(
                            key: const Key("amount_card"),
                            children: [
                              const AmountCardWidget(),
                              CommonSizedBoxWidget.height(16.h),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isVisible
                        ? Column(
                            key: const Key("credit_debit_scan"),
                            children: [
                              const CreditDebitScanWidget(),
                              CommonSizedBoxWidget.height(16.h),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isVisible
                        ? Column(
                            key: const Key("ai_assistant"),
                            children: [
                              const AiAssistantWidget(),
                              CommonSizedBoxWidget.height(16.h),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                  // RecentTransactionWidget sticking to the top

                  AnimatedSlide(
                    duration: const Duration(milliseconds: 700),
                    offset: _isVisible ? Offset.zero : Offset(0, -0.1),
                    child: Column(
                      children: [
                        if (!_isVisible) CommonSizedBoxWidget.height(300.h),
                        const RecentTransactionWidget(),
                      ],
                    ),
                  ),
                  // Adding extra padding to ensure visibility when _isVisible is false
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
