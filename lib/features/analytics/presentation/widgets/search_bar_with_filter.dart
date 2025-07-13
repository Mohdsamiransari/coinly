import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';

class SearchBarWithFilter extends StatelessWidget {
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onFilterTap;
  final TextEditingController controller;

  const SearchBarWithFilter({
    super.key,
    required this.onSearchChanged,
    required this.onFilterTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.black,
              sizeVariant: SizeVariant.medium,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.black54),
              hintText: 'search',
              hintStyle: AppTextStyles.getStyle(
                colorVariant: ColorVariant.primaryGrey,
                sizeVariant: SizeVariant.medium,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Material(
          color: Colors.grey[900],
          shape: const CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(24.r),
            onTap: onFilterTap,
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Icon(Icons.filter_alt, color: Colors.white, size: 24.r),
            ),
          ),
        ),
      ],
    );
  }
} 