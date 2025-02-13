import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
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
    return Scaffold(
      appBar: AppBar(
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
        child: Column(
          children: [
            CommonSizedBoxWidget.height(50.h),
            Center(
              child: CircleAvatar(
                maxRadius: 60.r,
                child: ImagePreview(
                  width: 120.r,
                  height: 120.r,
                  path: friendProfileImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CommonSizedBoxWidget.height(12.h),
            Text(
              friendName,
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.extraLarge,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
            CommonSizedBoxWidget.height(4.h),
            Text(
              friendEmail,
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryWhite,
                sizeVariant: SizeVariant.mediumLarge,
                fontWeightVariant: FontWeightVariant.medium,
              ),
            ),
            CommonSizedBoxWidget.height(40.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AmountOweTextCard(
                  amount: 16,
                  owedBy: "Owed by you",
                ),
                Container(
                  height: 30.h,
                  width: 2.w,
                  color: AppColors.white,
                ),
                const AmountOweTextCard(
                  amount: 20,
                  owedBy: "Owed to you",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AmountOweTextCard extends StatelessWidget {
  final double amount;
  final String owedBy;
  const AmountOweTextCard({
    super.key,
    required this.amount,
    required this.owedBy,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "\$$amount\n",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.mediumLarge,
          fontWeightVariant: FontWeightVariant.medium,
        ),
        children: [
          TextSpan(
            text: owedBy,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryWhite,
              sizeVariant: SizeVariant.mediumLarge,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
