import 'package:coinly/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Friends",
        style: AppTextStyles.getStyle(
          colorVariant: ColorVariant.white,
          sizeVariant: SizeVariant.large,
          fontWeightVariant: FontWeightVariant.bold,
        ),
      ),
    );
  }
}
