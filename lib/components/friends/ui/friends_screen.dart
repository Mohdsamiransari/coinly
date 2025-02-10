import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> connectionData = [
      {"title": "Find People", "icon": AppAssets.apple},
      {"title": "Invite Friend", "icon": AppAssets.email},
      {"title": "Scan QR", "icon": AppAssets.eye},
    ];
    List<Map<String, dynamic>> users = [
      {
        "name": "Alex Johnson",
        "email": "alex.johnson@example.com",
        "amount": 150,
        "imageUrl": "assets/images/user1.png"
      },
      {
        "name": "Emily Davis",
        "email": "emily.davis@example.com",
        "amount": 200,
        "imageUrl": "assets/images/user2.png"
      },
      {
        "name": "Michael Brown",
        "email": "michael.brown@example.com",
        "amount": 300,
        "imageUrl": "assets/images/user3.png"
      },
      {
        "name": "Sarah Miller",
        "email": "sarah.miller@example.com",
        "amount": 50,
        "imageUrl": "assets/images/user4.png"
      },
      {
        "name": "Jessica Taylor",
        "email": "jessica.taylor@example.com",
        "amount": 120,
        "imageUrl": "assets/images/user5.png"
      },
    ];

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Connections",
                style: AppTextStyles.getStyle(
                  colorVariant: ColorVariant.white,
                  sizeVariant: SizeVariant.mediumLarge,
                  fontWeightVariant: FontWeightVariant.semiBold,
                ),
              ),
              CommonButtonWidget(
                width: 24.r,
                height: 24.r,
                backgroundColor: Colors.transparent,
                onPressed: () {},
                btnChild: ImagePreview(
                  path: AppAssets.search,
                  color: AppColors.white,
                  width: 24.r,
                  height: 24.r,
                ),
              )
            ],
          ),
          CommonSizedBoxWidget.height(16.h),
          SizedBox(
            height: 130.r,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Material(
                  color: index % 2 != 0
                      ? AppColors.tertiaryBlue
                      : AppColors.secondaryBlue,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {},
                    child: connectionCard(
                        title: connectionData[index]["title"],
                        icon: connectionData[index]["icon"],
                        index: index),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.width(8.w),
              itemCount: connectionData.length,
            ),
          ),
          CommonSizedBoxWidget.height(16.h),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      minTileHeight: 40.h,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.secondaryBlue,
                        radius: 22.r,
                        child: ImagePreview(path: users[index]["imageUrl"])
                      ),
                      title: Text(
                        users[index]["name"],
                        style: AppTextStyles.getStyle(
                          colorVariant: ColorVariant.white,
                          sizeVariant: SizeVariant.medium,
                          fontWeightVariant: FontWeightVariant.semiBold,
                        ),
                      ),
                      subtitle: Text(
                        users[index]["email"],
                        style: AppTextStyles.getStyle(
                          colorVariant: ColorVariant.primaryWhite,
                          sizeVariant: SizeVariant.small,
                          fontWeightVariant: FontWeightVariant.medium,
                        ),
                      ),
                      trailing: Text(
                        "-\$${users[index]["amount"]}",
                        style: AppTextStyles.getStyle(
                          colorVariant: ColorVariant.white,
                          sizeVariant: SizeVariant.mediumLarge,
                          fontWeightVariant: FontWeightVariant.semiBold,
                        ),
                      ),
                    ),
                    if (index == users.length)
                      CommonSizedBoxWidget.height(40.h),
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.height(8.h),
              itemCount: users.length,
            ),
          ),
        ],
      ),
    );
  }

  Container connectionCard(
      {required String title, required String icon, required int index}) {
    return Container(
      height: 130.r,
      width: 130.r,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Spacer(),
          ImagePreview(
            path: icon,
            color: AppColors.white,
            width: 24.r,
            height: 24.r,
          ),
          CommonSizedBoxWidget.height(4.h),
          Text(
            title,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.medium,
              fontWeightVariant: FontWeightVariant.medium,
            ),
          )
        ],
      ),
    );
  }
}
