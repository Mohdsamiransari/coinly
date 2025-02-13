import 'package:coinly/components/common/common_input_widget.dart';
import 'package:coinly/components/common/image_preview.dart';
import 'package:coinly/utils/app_assets.dart';
import 'package:coinly/utils/app_colors.dart';
import 'package:coinly/utils/app_strings.dart';
import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SearchFriendsScreen extends StatefulWidget {
  const SearchFriendsScreen({super.key});

  @override
  State<SearchFriendsScreen> createState() => _SearchFriendsScreenState();
}

class _SearchFriendsScreenState extends State<SearchFriendsScreen> {
  final FocusNode searchFocusNode = FocusNode();

  // @override
  // void dispose() {
  //   searchFocusNode.dispose();
  //   super.dispose();
  // }

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
        title: Text(
          "Search Friends",
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.large,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            CommonInputWidget(
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
          ],
        ),
      ),
    );
  }
}
