import 'dart:developer';

import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/expense/ui/widgets/expense_category_widget.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DebitCreditExpenseScreen extends StatefulWidget {
  final bool isDebitScreen;

  const DebitCreditExpenseScreen({super.key, required this.isDebitScreen});

  @override
  State<DebitCreditExpenseScreen> createState() => _DebitExpenseScreenState();
}

class _DebitExpenseScreenState extends State<DebitCreditExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: 16.r,
          ),
        ),
        title: Text(
          "${widget.isDebitScreen ? "Debit" : "Credit"} Expense",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.mediumLarge,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonInputWidget(
              isFilled: true,
              fillColor: AppColors.secondaryBlue,
              borderRadius: BorderRadius.circular(8.r),
              hintText: AppStrings.amount,
              prefixIcon: Container(
                margin: EdgeInsets.only(right: 8.r),
                width: 40.w,
                decoration: BoxDecoration(
                    color: AppColors.tertiaryBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      bottomLeft: Radius.circular(8.r),
                    )),
                child: const Icon(
                  Icons.attach_money_rounded,
                  color: AppColors.white,
                ),
              ),
              textInputType: TextInputType.number,
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonInputWidget(
              isFilled: true,
              fillColor: AppColors.secondaryBlue,
              borderRadius: BorderRadius.circular(8.r),
              hintText: AppStrings.expenseName,
              textInputType: TextInputType.number,
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonInputWidget(
              isFilled: true,
              fillColor: AppColors.secondaryBlue,
              borderRadius: BorderRadius.circular(8.r),
              hintText: AppStrings.date,
              textInputType: TextInputType.datetime,
              suffixIcon: Container(
                margin: EdgeInsets.only(left: 8.r),
                width: 40.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                )),
                child: const Icon(
                  Icons.calendar_month,
                  color: AppColors.white,
                ),
              ),
            ),
            CommonSizedBoxWidget.height(16.h),
            CommonInputWidget(
              isFilled: true,
              fillColor: AppColors.secondaryBlue,
              borderRadius: BorderRadius.circular(8.r),
              hintText: AppStrings.otherDetails,
              textInputType: TextInputType.datetime,
            ),
            CommonSizedBoxWidget.height(16.h),
            ExpenseCategoryWidget(
              onPressedSelectedData: (index) {
                setState(() {
                  log("Selected Expense Category Index $index");
                });
              },
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButtonWidget(
                  onPressed: () {
                    widget.isDebitScreen
                        ? setState(() {
                            log("Debit Screen");
                          })
                        : setState(() {
                            log("Credit Screen");
                          });
                  },
                  backgroundColor: AppColors.secondaryBlue,
                  btnLabelStyle: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.white,
                    sizeVariant: SizeVariant.medium,
                    fontWeightVariant: FontWeightVariant.medium,
                  ),
                  width: MediaQuery.of(context).size.width * .44,
                  btnLabel: widget.isDebitScreen ? "Debit" : " Credit",
                ),
                CommonButtonWidget(
                  width: MediaQuery.of(context).size.width * .44,
                  btnLabel: "Next",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
