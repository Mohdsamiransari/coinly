import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> transactions = [
      {
        "title": "Electricity Bill",
        "date": "4 September",
        "time": "8:30 pm",
        "amount": 150,
        "expenseType": "electricity",
        "iconUrl": "assets/images/expenseicon1.png"
      },
      {
        "title": "Groceries",
        "date": "4 September",
        "time": "9:00 pm",
        "amount": 50,
        "expenseType": "grocery",
        "iconUrl": "assets/images/expenseicon2.png"
      },
      {
        "title": "Dinner",
        "date": "5 September",
        "time": "8:00 pm",
        "amount": 100,
        "expenseType": "food",
        "iconUrl": "assets/images/expenseicon3.png"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppStrings.recentTransactions,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.semiBold,
          ),
        ),
        CommonSizedBoxWidget.height(16.h),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              minTileHeight: 40.h,
              leading: CircleAvatar(
                  backgroundColor: AppColors.secondaryBlue,
                  radius: 22.r,
                  child: ImagePreview(path: transactions[index]["iconUrl"])),
              title: Text(
                transactions[index]["title"],
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.medium,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
              ),
              subtitle: Text(
                "${transactions[index]["date"]} - ${transactions[index]["time"]}",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.primaryWhite,
                  sizeVariant: SizeVariant.small,
                  fontWeightVariant: FontWeightVariant.medium,
                ),
              ),
              trailing: Text(
                "-\$${transactions[index]["amount"]}",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.mediumLarge,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
              CommonSizedBoxWidget.height(8.h),
          itemCount: transactions.length,
        ),
      
      ],
    );
  }
}
