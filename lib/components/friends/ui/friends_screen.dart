import 'package:coinly/components/common/common_button_widget.dart';
import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/router/router_constant.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<Offset>> _connectionSlideAnimations;
  late List<Animation<Offset>> _friendSlideAnimations;
  late List<Animation<double>> _opacityAnimations;

  final List<Map<String, dynamic>> connectionData = [
    {"title": "Find People", "icon": AppAssets.apple},
    {"title": "Invite Friend", "icon": AppAssets.email},
    {"title": "Scan QR", "icon": AppAssets.eye},
  ];

  final List<Map<String, dynamic>> users = [
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));

    /// **Connections Animation (Slide from Right to Left)**
    _connectionSlideAnimations = List.generate(
      connectionData.length,
      (index) =>
          Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(index * 0.15, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    /// **Friends List Animation (Slide from Right to Left)**
    _friendSlideAnimations = List.generate(
      users.length,
      (index) =>
          Tween<Offset>(begin: const Offset(1.5, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    /// **Opacity Animation (For Smooth Fade-In)**
    _opacityAnimations = List.generate(
      users.length,
      (index) => Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(index * 0.01, 1.0, curve: Curves.easeIn),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Header Row**
          Row(
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

          /// **Animated Connections List**
          SizedBox(
            height: 130.r,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: connectionData.length,
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.width(8.w),
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: _connectionSlideAnimations[index],
                  child: connectionCard(
                    title: connectionData[index]["title"],
                    icon: connectionData[index]["icon"],
                  ),
                );
              },
            ),
          ),

          CommonSizedBoxWidget.height(16.h),

          /// **Friends List with Staggered Slide Animation**
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: users.length,
              separatorBuilder: (context, index) =>
                  CommonSizedBoxWidget.height(8.h),
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: _friendSlideAnimations[index],
                  child: FadeTransition(
                    opacity: _opacityAnimations[index],
                    child: ListTile(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RouterConstant.friendsProfileScreen,
                            extra: {
                              "friendEmail": users[index]["email"],
                              "friendName": users[index]["name"],
                              "friendProfileImage": users[index]["imageUrl"]
                            });
                      },
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.secondaryBlue,
                        radius: 22.r,
                        child: ImagePreview(path: users[index]["imageUrl"]),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// **Connection Card Widget**
  Widget connectionCard({required String title, required String icon}) {
    return Container(
      height: 130.r,
      width: 130.r,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
