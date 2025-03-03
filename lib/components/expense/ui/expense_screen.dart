import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

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
                width: 45,
                height: 45,
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.primaryWhite,
                    showDragHandle: true,
                    context: context,
                    builder: (context) {
                      double currentValue = 50000;

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
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: AppColors.secondaryBlue,
                                    inactiveTrackColor: AppColors.white,
                                    thumbColor: AppColors.secondaryBlue,
                                    trackHeight: 3,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 10),
                                  ),
                                  child: Slider(
                                    value: currentValue,
                                    min: 0,
                                    max: 50000,
                                    onChanged: (value) {
                                      setState(() {
                                        currentValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 10.w,
                                  top: 25.h,
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[400]),
                                  ),
                                ),
                                Positioned(
                                  top: 25.h,
                                  child: Text(
                                    "${currentValue.floor()}", // Convert to K format
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Positioned(
                                  right: 10.w,
                                  top: 25.h,
                                  child: Text(
                                    "1L",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[400]),
                                  ),
                                )
                              ],
                            ),
                            CommonSizedBoxWidget.height(24.w),
                          ],
                        ),
                      );
                    },
                  );
                },
                btnChild: const Icon(
                  Icons.filter_alt_outlined,
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(8.r),
                backgroundColor: AppColors.secondaryBlue,
              )
            ],
          ),
        ],
      ),
    );
  }
}
