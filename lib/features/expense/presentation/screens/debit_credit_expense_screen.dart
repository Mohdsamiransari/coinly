import 'dart:developer';

import 'package:coinly/core/common/common_button_widget.dart';
import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/expense/bloc/expense_bloc.dart';
import 'package:coinly/features/expense/data/model/add_expense_model.dart';
import 'package:coinly/features/expense/presentation/widgets/expense_category_widget.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:coinly/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_colors.dart';
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
  late final ExpenseBloc _expenseBloc;

  DateTime _selectTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  late TextEditingController _dateController;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();

  // Track previous state to prevent duplicate processing

  @override
  void initState() {
    super.initState();
    _expenseBloc = context.read<ExpenseBloc>();
    _expenseBloc.add(GetExpenseCategoryEvent());
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

  void _validateAndSubmit(RequestStatus<int> selectedCategoryState) {
    if (_formKey.currentState!.validate() &&
        selectedCategoryState.data != null) {
      final Map<String, dynamic> expenseData = {
        "expense_name": _expenseNameController.text,
        "expense_date": _dateController.text,
        "expense_amount": int.parse(_amountController.text),
        "expense_category_id": selectedCategoryState.data,
        "expense_note": _otherDetailsController.text,
        "expense_type": widget.isDebitScreen ? "debit" : "credit",
        "expense_currency": "INR",
        "expense_method": "upi"
        // "splits":[{
        //     "friend_id":8,
        //     "amount":100
        // }]
      };
      _expenseBloc.add(AddExpenseEvent(data: expenseData));
    } else if (selectedCategoryState.data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an expense category.")),
      );
    }
  }

  void clearForm() {
    _amountController.clear();
    _otherDetailsController.clear();
    _expenseNameController.clear();
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
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        bloc: _expenseBloc,
        listener: (context, state) {
          if (state.addTransactionResponse.isSuccess && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("expense created successfully")),
            );
            clearForm();

            context.read<HomeBloc>().add(GetTotalBalanceEvent());
            _expenseBloc.add(GetRecentTransactionsEvent());
          } else if (state.addTransactionResponse.isError && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.addTransactionResponse.error ?? "")),
            );
          }
        },
        builder: (context, state) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CommonInputWidget(
                      controller: _amountController,
                      isFilled: true,
                      fillColor: AppColors.secondaryBlue,
                      borderRadius: BorderRadius.circular(8.r),
                      hintText: AppStrings.amount,
                      isPrefixBoxConstraints: false,
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
                        if (value == "0") {
                          return "Amount cannot be zero";
                        }
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
                      controller: _expenseNameController,
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
                      isSuffixBoxConstraints: false,
                      suffixIcon: Container(
                        margin: EdgeInsets.only(left: 8.r),
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: AppColors.tertiaryBlue,
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
                      textStyle: AppTextStyles.getStyle(
                          colorVariant: ColorVariant.primaryWhite,
                          sizeVariant: SizeVariant.medium,
                          fontWeightVariant: FontWeightVariant.regular),
                    ),
                    CommonSizedBoxWidget.height(16.h),
                    CommonInputWidget(
                      controller: _otherDetailsController,
                      isFilled: true,
                      fillColor: AppColors.secondaryBlue,
                      borderRadius: BorderRadius.circular(8.r),
                      hintText: AppStrings.otherDetails,
                    ),
                    CommonSizedBoxWidget.height(16.h),
                    ExpenseCategoryWidget(
                      state: state,
                      expenseBloc: _expenseBloc,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonButtonWidget(
                          onPressed: () {
                            _validateAndSubmit(
                              state.selectedExpenseCategory,
                            );
                          },
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
                          onPressed: () {
                            _validateAndSubmit(
                              state.selectedExpenseCategory,
                            );
                          },
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
          );
        },
      ),
    );
  }

  _selectDate() {
    showModalBottomSheet(
      backgroundColor: AppColors.secondaryBlue,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScrollDateTimePicker(
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
            ),
            CommonSizedBoxWidget.height(20.h),
          ],
        );
      },
    );
  }
}
