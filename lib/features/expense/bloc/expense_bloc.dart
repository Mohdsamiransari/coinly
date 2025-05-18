import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinly/core/common/model/request_status.dart';
import 'package:coinly/features/expense/data/model/transaction_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  // In-memory storage for transactions
  final List<Transaction> _transactions = [
    const Transaction(
      title: "Electricity Bill",
      date: "4 September",
      time: "8:30 pm",
      amount: 150,
      expenseType: "electricity",
      iconUrl: "assets/images/expenseicon1.png",
    ),
    const Transaction(
      title: "Groceries",
      date: "4 September",
      time: "9:00 pm",
      amount: 50,
      expenseType: "grocery",
      iconUrl: "assets/images/expenseicon2.png",
    ),
    const Transaction(
      title: "Dinner",
      date: "5 September",
      time: "8:00 pm",
      amount: 100,
      expenseType: "food",
      iconUrl: "assets/images/expenseicon3.png",
    ),
  ];

  ExpenseBloc() : super(const ExpenseState()) {
    on<GetRecentTransactionsEvent>(_getRecentTransactionsEvent);
    on<AddTransactionEvent>(_addTransactionEvent);
    on<GetExpenseCategoryEvent>(_getExpenseCategoryEvent);
    on<SelectExpenseCategoryEvent>(_selectExpenseCategoryEvent);
  }

  FutureOr<void> _getRecentTransactionsEvent(
    GetRecentTransactionsEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        transactions: const RequestStatus.loading(),
      ));
      // await Future.delayed(const Duration(seconds: 2));

      if (_transactions.isEmpty) {
        emit(state.copyWith(
          transactions: const RequestStatus.empty(),
        ));
        return;
      }

      log("Recent Transaction $_transactions");

      emit(state.copyWith(
        transactions: RequestStatus.success(data: _transactions),
      ));
    } catch (e) {
      log("Error getting recent transactions: $e");
      emit(state.copyWith(
        transactions: const RequestStatus.error("Failed to load transactions"),
      ));
    }
  }

  FutureOr<void> _addTransactionEvent(
    AddTransactionEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        addTransaction: const RequestStatus.loading(),
      ));
      await Future.delayed(const Duration(seconds: 1));
      state.transactions.data?.add(event.transaction);

      emit(state.copyWith(
        addTransaction: const RequestStatus.success(),
      ));
    } catch (e) {
      log("Error adding transaction: $e");
      emit(state.copyWith(
        addTransaction: const RequestStatus.error("Failed to add transaction"),
      ));
    }
  }

  FutureOr<void> _getExpenseCategoryEvent(
    GetExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        getExpenseCategory: const RequestStatus.loading(),
      ));
      await Future.delayed(const Duration(seconds: 2));

      final List<Map<String, dynamic>> categories = [
        {"name": "Electricity", "icon": "assets/images/expenseicon1.png"},
        {"name": "Groceries", "icon": "assets/images/expenseicon2.png"},
        {"name": "Food", "icon": "assets/images/expenseicon3.png"},
      ];

      emit(state.copyWith(
        getExpenseCategory: RequestStatus.success(data: categories),
      ));
    } catch (e) {
      log("Error getting expense categories: $e");
      emit(state.copyWith(
        getExpenseCategory:
            const RequestStatus.error("Failed to load categories"),
      ));
    }
  }

  FutureOr<void> _selectExpenseCategoryEvent(
    SelectExpenseCategoryEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedExpenseCategory: RequestStatus.success(data: event.category),
      ));
    } catch (e) {
      log("Error selecting expense category: $e");
      emit(state.copyWith(
        selectedExpenseCategory:
            const RequestStatus.error("Failed to select category"),
      ));
    }
  }
}
