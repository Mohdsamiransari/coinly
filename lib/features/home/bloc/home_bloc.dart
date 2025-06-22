import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/home/data/model/amount_card.model.dart';
import 'package:coinly/features/home/data/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TextEditingController amountController = TextEditingController();

  final Map<String, dynamic> amountCardData = {
    "totalBalance": 3000,
    "totalCredit": 2600,
    "totalDebit": 400,
  };

  HomeBloc() : super(const HomeState()) {
    on<GetTotalBalanceEvent>(_getTotalBalanceEvent);
    on<AddNewTotalBalanceEvent>(_addNewTotalBalanceEvent);
  }

  FutureOr<void> _getTotalBalanceEvent(
    GetTotalBalanceEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(state.copyWith(amountCardData: const RequestStatus.loading()));

      final amountResponse = await HomeRepository().amountData();

      if (amountResponse?.status != "success") {
        emit(state.copyWith(
            amountCardData:
                RequestStatus.error(amountResponse?.message ?? "")));
      }

      if (amountResponse?.data == null) {
        emit(state.copyWith(
          amountCardData: const RequestStatus.empty(),
        ));
      }

      emit(state.copyWith(
        amountCardData: RequestStatus.success(data: amountResponse?.data),
      ));
    } catch (e) {
      log("Error getting total balance: $e");
      emit(state.copyWith(
          amountCardData: const RequestStatus.error("Failed to load data")));
    }
  }

  FutureOr<void> _addNewTotalBalanceEvent(
    AddNewTotalBalanceEvent event,
    Emitter<HomeState> emit,
  ) {
    try {
      final newAmount = int.tryParse(amountController.text);
      if (newAmount == null) {
        emit(state.copyWith(
          amountCardData: const RequestStatus.error("Invalid amount"),
        ));
        // return;
      }

      // final totalAccountBalance =
      //     state.amountCardData.data?["totalBalance"] + (newAmount ?? 0);

      // amountController.clear();

      // emit(state.copyWith(
      //   amountCardData: RequestStatus.success(data: {
      //     "totalBalance": totalAccountBalance,
      //     "totalCredit": state.amountCardData.data?["totalCredit"],
      //     "totalDebit": state.amountCardData.data?["totalDebit"],
      //   }),
      // ));
    } catch (e) {
      log("Error adding new balance: $e");
      emit(state.copyWith(
          amountCardData:
              const RequestStatus.error("Failed to add new balance")));
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
