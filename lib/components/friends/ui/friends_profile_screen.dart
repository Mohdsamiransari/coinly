import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/components/friends/ui/widgets/amount_owe_text_card_widget.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendsProfileScreen extends StatelessWidget {
  final String friendName;
  final String friendEmail;
  final String friendProfileImage;
  const FriendsProfileScreen({
    super.key,
    required this.friendEmail,
    required this.friendName,
    required this.friendProfileImage,
  });

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
      {
        "title": "Dinner",
        "date": "5 September",
        "time": "8:00 pm",
        "amount": 100,
        "expenseType": "food",
        "iconUrl": "assets/images/expenseicon3.png"
      },
      {
        "title": "Electricity Bill",
        "date": "4 September",
        "time": "8:30 pm",
        "amount": 150,
        "expenseType": "electricity",
        "iconUrl": "assets/images/expenseicon1.png"
      },
      {
        "title": "Dinner",
        "date": "5 September",
        "time": "8:00 pm",
        "amount": 100,
        "expenseType": "food",
        "iconUrl": "assets/images/expenseicon3.png"
      },
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
    ];
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              toolbarHeight: 0,
              expandedHeight: 260,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    CommonSizedBoxWidget.height(50.h),
                    Hero(
                      tag: "profile_$friendEmail",
                      child: Center(
                        child: CircleAvatar(
                          maxRadius: 55.r,
                          child: ImagePreview(
                            width: 110.r,
                            height: 110.r,
                            path: friendProfileImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    CommonSizedBoxWidget.height(12.h),
                    Text(
                      friendName,
                      style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.white,
                        sizeVariant: SizeVariant.large,
                        fontWeightVariant: FontWeightVariant.bold,
                      ),
                    ),
                    Text(
                      friendEmail,
                      style: AppTextStyles.getStyle(
                        colorVariant: ColorVariant.primaryWhite,
                        sizeVariant: SizeVariant.medium,
                        fontWeightVariant: FontWeightVariant.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CommonSizedBoxWidget.height(24.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const AmountOweTextCardWidget(
                        amount: 16,
                        owedBy: AppStrings.owedByYou,
                      ),
                      Container(
                        height: 30.h,
                        width: 2.w,
                        color: AppColors.white,
                      ),
                      const AmountOweTextCardWidget(
                        amount: 20,
                        owedBy: AppStrings.owedToYou,
                      ),
                    ],
                  ),
                  CommonSizedBoxWidget.height(24.h),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  minTileHeight: 40.h,
                  leading: CircleAvatar(
                      backgroundColor: AppColors.secondaryBlue,
                      radius: 22.r,
                      child:
                          ImagePreview(path: transactions[index]["iconUrl"])),
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
                ),
                childCount: transactions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
