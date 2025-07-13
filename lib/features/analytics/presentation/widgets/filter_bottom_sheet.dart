import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coinly/core/utils/app_styles.dart';

class FilterBottomSheet extends StatefulWidget {
  final int? initialMonth;
  final String? initialCategory;
  final double initialMinPrice;
  final double initialMaxPrice;
  final void Function(int? month, String? category, double minPrice, double maxPrice) onApply;

  const FilterBottomSheet({
    super.key,
    this.initialMonth,
    this.initialCategory,
    this.initialMinPrice = 0,
    this.initialMaxPrice = 1000,
    required this.onApply,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedMonth;
  String? selectedCategory;
  double minPrice = 0;
  double maxPrice = 1000;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> categories = [
    'Food', 'Transport', 'Entertainment', 'Shopping', 'Bills'
  ];

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
    selectedCategory = widget.initialCategory;
    minPrice = widget.initialMinPrice;
    maxPrice = widget.initialMaxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter",
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.white,
              sizeVariant: SizeVariant.large,
              fontWeightVariant: FontWeightVariant.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: selectedMonth,
                  decoration: InputDecoration(
                    labelText: 'Month',
                    labelStyle: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.primaryGrey,
                      sizeVariant: SizeVariant.small,
                    ),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  items: [
                    const DropdownMenuItem<int>(value: null, child: Text('All')),
                    ...List.generate(months.length, (i) => DropdownMenuItem(
                          value: i,
                          child: Text(months[i]),
                        )),
                  ],
                  onChanged: (val) => setState(() => selectedMonth = val),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: AppTextStyles.getStyle(
                      colorVariant: ColorVariant.primaryGrey,
                      sizeVariant: SizeVariant.small,
                    ),
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  items: [
                    const DropdownMenuItem<String>(value: null, child: Text('All')),
                    ...categories.map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        )),
                  ],
                  onChanged: (val) => setState(() => selectedCategory = val),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Price Range',
            style: AppTextStyles.getStyle(
              colorVariant: ColorVariant.primaryGrey,
              sizeVariant: SizeVariant.small,
            ),
          ),
          RangeSlider(
            values: RangeValues(minPrice, maxPrice),
            min: 0,
            max: 1000,
            divisions: 20,
            labels: RangeLabels('₹${minPrice.toInt()}', '₹${maxPrice.toInt()}'),
            onChanged: (range) {
              setState(() {
                minPrice = range.start;
                maxPrice = range.end;
              });
            },
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    widget.onApply(selectedMonth, selectedCategory, minPrice, maxPrice);
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply', style: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.white,
                    sizeVariant: SizeVariant.medium,
                    fontWeightVariant: FontWeightVariant.bold,
                  )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 