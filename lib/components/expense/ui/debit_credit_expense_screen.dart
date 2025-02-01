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
import 'package:intl/intl.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class DebitCreditExpenseScreen extends StatefulWidget {
  final bool isDebitScreen;

  const DebitCreditExpenseScreen({super.key, required this.isDebitScreen});

  @override
  State<DebitCreditExpenseScreen> createState() => _DebitExpenseScreenState();
}

class _DebitExpenseScreenState extends State<DebitCreditExpenseScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectTime = DateTime.now();
  late TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>();
  int? _selectedCategoryIndex;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: _formatDate(_selectTime));

    // Initialize animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward(); // Start animation
  }

  @override
  void dispose() {
    _dateController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy, MMM dd').format(date);
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate() && _selectedCategoryIndex != null) {
      log("Form is valid! Proceeding...");
      log("Selected Category Index: $_selectedCategoryIndex");
      widget.isDebitScreen ? log("Debit Screen") : log("Credit Screen");
    } else if (_selectedCategoryIndex == null) {
      log("Please select an expense category.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an expense category.")),
      );
    }
  }

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
          "${widget.isDebitScreen ? AppStrings.debit : AppStrings.credit} ${AppStrings.expense}",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.mediumLarge,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Amount cannot be empty";
                    }
                    if (double.tryParse(value) == null) {
                      return "Enter a valid number";
                    }
                    return null;
                  },
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  isFilled: true,
                  fillColor: AppColors.secondaryBlue,
                  borderRadius: BorderRadius.circular(8.r),
                  hintText: AppStrings.expenseName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name cannot be empty";
                    }

                    return null;
                  },
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  controller: _dateController,
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
                  readOnly: true,
                  onTap: _selectDate,
                ),
                CommonSizedBoxWidget.height(16.h),
                CommonInputWidget(
                  isFilled: true,
                  fillColor: AppColors.secondaryBlue,
                  borderRadius: BorderRadius.circular(8.r),
                  hintText: AppStrings.otherDetails,
                ),
                CommonSizedBoxWidget.height(16.h),
                ExpenseCategoryWidget(
                  onPressedSelectedData: (index) {
                    setState(() {
                      _selectedCategoryIndex = index;
                      log("Selected Expense Category Index: $_selectedCategoryIndex");
                    });
                  },
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonButtonWidget(
                      onPressed: _validateAndSubmit,
                      backgroundColor: AppColors.secondaryBlue,
                      btnLabelStyle: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.white,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.medium,
                      ),
                      width: MediaQuery.of(context).size.width * .44,
                      btnLabel: widget.isDebitScreen
                          ? AppStrings.debit
                          : AppStrings.credit,
                    ),
                    CommonButtonWidget(
                      onPressed: _validateAndSubmit,
                      width: MediaQuery.of(context).size.width * .44,
                      btnLabel: AppStrings.next,
                    ),
                  ],
                ),
                CommonSizedBoxWidget.height(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate() {
    showModalBottomSheet(
      backgroundColor: AppColors.secondaryBlue,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return ScrollDateTimePicker(
          itemExtent: 54,
          infiniteScroll: true,
          style: DateTimePickerStyle(
            activeStyle: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
            inactiveStyle: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
          dateOption: DateTimePickerOption(
            dateFormat: DateFormat('yyyyMMMdd'),
            minDate: DateTime(1999, 12),
            maxDate: DateTime(2099, 12),
            initialDate: _selectTime,
          ),
          onChange: (datetime) => setState(() {
            _selectTime = datetime;
            _dateController.text = _formatDate(datetime);
          }),
        );
      },
    );
  }
}
