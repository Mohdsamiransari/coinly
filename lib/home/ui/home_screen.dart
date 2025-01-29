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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AmountCardWidget(),
                  CommonSizedBoxWidget.height(16.h),
                  const CreditDebitScanWidget(),
                  CommonSizedBoxWidget.height(16.h),
                  const AiAssistantWidget(),
                  CommonSizedBoxWidget.height(16.h),
                  const RecentTransactionWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
