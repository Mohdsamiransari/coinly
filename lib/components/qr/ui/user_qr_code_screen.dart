import 'package:coinly/components/common/common_sized_box_widget.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserQrCodeScreen extends StatelessWidget {
  const UserQrCodeScreen({super.key});

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
        padding: EdgeInsets.all(20.r),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: AppColors.secondaryBlue,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.person_2_rounded),
                    ),
                    CommonSizedBoxWidget.width(12.w),
                    Text(
                      "Jacob Lee",
                      style: AppTextStyles.getStyle(
                          colorVariant: ColorVariant.white,
                          sizeVariant: SizeVariant.large,
                          fontWeightVariant: FontWeightVariant.semiBold),
                    ),
                  ],
                ),
                CommonSizedBoxWidget.height(40.h),
                QrImageView(
                  data: 'This is a simple QR code',
                  version: QrVersions.auto,
                  size: 320,
                  gapless: false,
                  // ignore: deprecated_member_use
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
