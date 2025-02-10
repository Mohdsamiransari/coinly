import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController amountController = TextEditingController();

  String totalBalance = "0";
  HomeBloc() : super(HomeInitial()) {
    on<AddNewTotalBalanceEvent>(_addNewTotalBalanceEvent);
  }

  FutureOr<void> _addNewTotalBalanceEvent(
      AddNewTotalBalanceEvent event, Emitter<HomeState> emit) {
    try {
      totalBalance = amountController.text;
      amountController.clear();
      emit(AddNewTotalBalanceState());
    } catch (e) {
      log("Error Adding New Balance to Total Balance $e");
    }
  }
}
