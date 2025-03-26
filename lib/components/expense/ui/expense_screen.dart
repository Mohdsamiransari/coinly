import 'dart:developer';

import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/components/expense/ui/widgets/expense_card_widget.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final FocusNode searchFocusNode = FocusNode();

  List<String> expenseType = [
    "All",
    "Electricity",
    "Groceries",
    "Home",
    "Travel",
    "Food",
    "Clothing",
    "Beauty"
  ];
  List<String> sortName = [
    "Ascending",
    "Descending",
    "Highest Price",
    "Lowest Price",
    "Newest",
    "Oldest",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppStrings.history,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.mediumLarge,
              fontWeightVariant: FontWeightVariant.semiBold,
            ),
          ),
          CommonSizedBoxWidget.height(16.h),
          Row(
            children: [
              Expanded(
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
              ),
              CommonSizedBoxWidget.width(8.h),
              CommonButtonWidget(
                width: 42.r,
                height: 42.r,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.primaryWhite,
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 16.w, top: 16.h, bottom: 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CommonButtonWidget(
                                    height: 40.h,
                                    btnLabel: expenseType[index],
                                    btnLabelStyle: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.mediumSmall,
                                      fontWeightVariant:
                                          FontWeightVariant.medium,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 12.h),
                                    backgroundColor: AppColors.secondaryBlue,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    CommonSizedBoxWidget.width(8.w),
                                itemCount: expenseType.length,
                              ),
                            ),
                            CommonSizedBoxWidget.height(16.w),
                            Text(
                              "Sort by",
                              style: AppTextStyles.getStyle(
                                colorVariant: ColorVariant.primary,
                                sizeVariant: SizeVariant.medium,
                                fontWeightVariant: FontWeightVariant.medium,
                              ),
                            ),
                            CommonSizedBoxWidget.height(16.w),
                            SizedBox(
                              height: 40.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CommonButtonWidget(
                                    height: 40.h,
                                    btnLabel: sortName[index],
                                    btnLabelStyle: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.mediumSmall,
                                      fontWeightVariant:
                                          FontWeightVariant.medium,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 12.h),
                                    backgroundColor: AppColors.secondaryBlue,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    CommonSizedBoxWidget.width(8.w),
                                itemCount: sortName.length,
                              ),
                            ),
                            CommonSizedBoxWidget.height(16.w),
                            Text(
                              "Amount",
                              style: AppTextStyles.getStyle(
                                colorVariant: ColorVariant.primary,
                                sizeVariant: SizeVariant.medium,
                                fontWeightVariant: FontWeightVariant.medium,
                              ),
                            ),
                            FlutterSlider(
                              values: const [300],
                              max: 20000,
                              min: 0,
                              trackBar: FlutterSliderTrackBar(
                                inactiveTrackBar: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                activeTrackBar: BoxDecoration(
                                  color: AppColors.secondaryBlue,
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                              ),
                              handler: FlutterSliderHandler(
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const SizedBox.shrink()),
                              onDragging:
                                  (handlerIndex, lowerValue, upperValue) {
                                log("Lower Value: $lowerValue");
                                setState(() {});
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonButtonWidget(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height: 40.h,
                                    btnLabel: "Cancel",
                                    btnLabelStyle: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.secondary,
                                      sizeVariant: SizeVariant.medium,
                                      fontWeightVariant: FontWeightVariant.bold,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 12.h),
                                    backgroundColor: AppColors.white,
                                  ),
                                  CommonButtonWidget(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height: 40.h,
                                    btnLabel: "Apply",
                                    btnLabelStyle: AppTextStyles.getStyle(
                                      colorVariant: ColorVariant.white,
                                      sizeVariant: SizeVariant.medium,
                                      fontWeightVariant: FontWeightVariant.bold,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.w, vertical: 12.h),
                                    backgroundColor: AppColors.secondaryBlue,
                                  ),
                                ],
                              ),
                            ),
                            CommonSizedBoxWidget.height(24.w),
                          ],
                        ),
                      );
                    },
                  );
                },
                btnChild:  Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.white,
                  size: 24.r,
                ),
                borderRadius: BorderRadius.circular(8.r),
                backgroundColor: AppColors.secondaryBlue,
              )
            ],
          ),
          CommonSizedBoxWidget.height(16.h),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const ExpenseCardWidget(),
                    if (index == 13)
                      CommonSizedBoxWidget.height(40.h), // Only for last item
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.height(16.h),
              itemCount: 14,
            ),
          ),
        ],
      ),
    );
  }
}
