import 'package:coinly/core/common/common_bottomsheet_widget.dart';
import 'package:coinly/core/common/common_button_widget.dart';
import 'package:coinly/core/common/common_input_widget.dart';
import 'package:coinly/core/common/common_sized_box_widget.dart';
import 'package:coinly/core/common/image_preview.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/core/helper/app_helpers.dart';
import 'package:coinly/features/home/bloc/home_bloc.dart';
import 'package:coinly/core/utils/app_assets.dart';
import 'package:coinly/core/utils/app_colors.dart';
import 'package:coinly/core/utils/app_strings.dart';
import 'package:coinly/core/utils/app_styles.dart';
import 'package:coinly/features/home/data/model/amount_card.model.dart';
import 'package:coinly/features/home/presentation/shimmer/amount_card_shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AmountCardWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  const AmountCardWidget({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final amountState = state.amountCardData;
        if (amountState.isLoading) {
          return const AmountCardShimmer();
        }

        if (amountState.isError) {
          return AppHelpers.buildErrorWidget(
              amountState.error ?? "Error loading data");
        }
        if (amountState.isEmpty) {
          return AppHelpers.buildEmptyWidget("No data available");
        }

        return _buildAmountCard(context, amountState);
      },
    );
  }

  Widget _buildAmountCard(
      BuildContext context, RequestStatus<Data> state) {
    return InkWell(
      onTap: () => commonBottomSheetWidget(
        context: context,
        child: Column(
          children: [
            Text(
              AppStrings.setYourCurrentBalance,
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.medium,
                fontWeightVariant: FontWeightVariant.medium,
              ),
            ),
            CommonSizedBoxWidget.height(16.h),
            _buildAmountInput(),
            CommonSizedBoxWidget.height(16.h),
            _buildAddButton(context),
            CommonSizedBoxWidget.height(16.h),
          ],
        ),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          _buildTopContainer(state),
          _buildBottomContainer(state),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return CommonInputWidget(
      borderRadius: BorderRadius.circular(24.r),
      controller: homeBloc.amountController,
      isFilled: true,
      fillColor: AppColors.white,
      hintText: AppStrings.addYourCurrentBalance,
      hintTextStyle: AppTextStyles.getStyle(
        colorVariant: ColorVariant.black,
        sizeVariant: SizeVariant.medium,
        fontWeightVariant: FontWeightVariant.medium,
      ),
      textStyle: AppTextStyles.getStyle(
        colorVariant: ColorVariant.black,
        sizeVariant: SizeVariant.medium,
        fontWeightVariant: FontWeightVariant.medium,
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return CommonButtonWidget(
      onPressed: () {
        homeBloc.add(AddNewTotalBalanceEvent());
        GoRouter.of(context).pop();
      },
      width: MediaQuery.of(context).size.width,
      btnLabel: AppStrings.add,
    );
  }

  Widget _buildTopContainer(RequestStatus<Data> state) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.secondaryBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.totalBalance,
                  style: AppTextStyles.getStyle(
                    colorVariant: ColorVariant.primaryWhite,
                    sizeVariant: SizeVariant.small,
                    fontWeightVariant: FontWeightVariant.medium,
                  ),
                ),
                ImagePreview(
                  path: AppAssets.edit,
                  width: 12.r,
                  height: 12.r,
                  color: AppColors.primaryWhite,
                )
              ],
            ),
            CommonSizedBoxWidget.height(8.h),
            Text(
              "\$${state.data?.totalBalance ?? 0}",
              style: AppTextStyles.getStyle(
                colorVariant: ColorVariant.white,
                sizeVariant: SizeVariant.extraLarge,
                fontWeightVariant: FontWeightVariant.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomContainer(RequestStatus<Data> state) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.tertiaryBlue,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn(
              AppStrings.totalDebit, "-\$${state.data?.totalDebit ?? 0}"),
          _buildInfoColumn(
              AppStrings.totalCredit, "+\$${state.data?.totalCredit ?? 0}"),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.primaryWhite,
            sizeVariant: SizeVariant.small,
            fontWeightVariant: FontWeightVariant.medium,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.getStyle(
            colorVariant: ColorVariant.white,
            sizeVariant: SizeVariant.medium,
            fontWeightVariant: FontWeightVariant.bold,
          ),
        ),
      ],
    );
  }
}
